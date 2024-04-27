#!/usr/bin/env bash

# author: Affan
#
#
#

TARGET=$1 # data/v19/rrnDB.unique.align

# STUB will allow to do this same thing for not only v19, but v4, v34 and v45 too
STUB=`echo $TARGET | sed -E "s/(.*rrnDB).*/\1/"`
STUB_TEMP=$STUB.temp
# below only keeps fields 2,3,5 in the sequence header and removes the last
# "-" which indicates negative strand (as it can cause problems for mothur)

ALIGN=$STUB.align
TEMP_ALIGN=$STUB_TEMP.align
TEMP_GROUPS=$STUB_TEMP.groups

sed -E "s/>.*\|(.*)\|(.*)\|.*\|(.*)_.$/>\1|\2|\3/" $ALIGN > $TEMP_ALIGN

# create grouping file, which contains one column for all 2,3,5 fields
# and 2nd column for only genome name
grep ">" $TEMP_ALIGN | sed -E "s/>((.*)\|.*\|.*)/\1 \2/" > $TEMP_GROUPS

# below provides the count table for unque sequences in each genome_accession
code/mothur/mothur "#unique.seqs(fasta=$TEMP_ALIGN); count.seqs(group=$TEMP_GROUPS, compress=FALSE)"

mv $STUB_TEMP.unique.align $STUB.unique.align
mv $STUB_TEMP.count_table $STUB.count_table

rm $STUB_TEMP.names
rm $STUB_TEMP.groups
rm $STUB_TEMP.align
