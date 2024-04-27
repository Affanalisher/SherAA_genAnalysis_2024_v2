#!/usr/bin/env bash

# author: Affan
# dependency: data/raw/rrnDB-5.8_16S_rRNA.align
# input: the target name, which is really the output
#        data/<region>/rrnDB.align
#
#


target=$1

region=`echo "$target" | sed -E "s/.*\/(.*)\/.*/\1/"`

path=`echo "$target" | sed -E "s/(.*\/.*)\/.*/\1/"`

# echo "$target"
# echo "$region"
# echo "$path"

# if else statement to look for other regions too e.g. v4, v19, etc
# pay extra attention to the spaces because they matter e.g. space between
# if and [[]]
if [[ "$region" = "v19" ]]
then
  start=1044
  end=43116
  echo "region: $region"
elif [[ "$region" = "v4" ]]
then
  start=13862
  end=23444
  echo "region: $region"
elif [[ "$region" = "v34" ]]
then
  start=6428
  end=23444
  echo "region: $region"
elif [[ "$region" = "v45" ]]
then
  start=13862
  end=27659
  echo "region: $region"
else
  echo "FAIL: We don't have the coordinates for $region"
  exit 1 # this means leave the script and exit the value 1
fi

echo "start: $start"
echo "end: $end"



# extract the region in fasta we are interested in using pcr.seqs

# create the required directory and use -p to force it in case it already exists
mkdir -p $path

code/mothur/mothur "#pcr.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.align, start=$start,
end=$end, outputdir=$path); filter.seqs(vertical=TRUE)"

# this checks if mothur executed successfully.
# if mothur executes successfully, then touch the files that might not have between
# generated in pcr.seqs because the sequences spanned the desired region'#!/bin/sh
# coordinates

if [[ $? -eq 0 ]] # -eq: equal, -ne: not equal, -gt: greater than, -lt: less than
then # ^\.* means that repeat the period as many times as it comes.
  sed "s/^\.*/-/" $path/rrnDB-5.8_16S_rRNA.pcr.filter.fasta > $path/rrnDB-5.8_16S_rRNA.pcr.filter.test.fasta
  touch $path/rrnDB-5.8_16S_rRNA.bad.accnos
  touch $path/rrnDB-5.8_16S_rRNA.scrap.pcr.align
else
  echo "FAIL: mothur ran into a problem"
  exit 1
fi


# moves the pcr and filter file and renames it to be the same as target
# i.e. rrnDB.align
mv $path/rrnDB-5.8_16S_rRNA.pcr.filter.test.fasta $target

# moves the bad accnos file and renames it to be the same as target
# i.e. rrnDB.bad.accnos
mv $path/rrnDB-5.8_16S_rRNA.bad.accnos $path/rrnDB.bad.accnos

# remove these files as you may not need them.
rm $path/rrnDB-5.8_16S_rRNA.pcr.align
rm $path/rrnDB-5.8_16S_rRNA.scrap.pcr.align
rm $path/rrnDB-5.filter
rm $path/rrnDB-5.8_16S_rRNA.pcr.filter.fasta
