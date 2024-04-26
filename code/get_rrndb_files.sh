#!/usr/bin/env bash

# author: Affan
# inputs: Name of the file extracted from the archive without the path
# outputs: the appropriate rrnDB files into data/raw

target=$1

# dollar sign is good if there are spaces in file name
# single quotes will output $archive

# echo "$archive"

filename=`echo $target | sed "s/.*\///"`
path=`echo $target | sed -E "s/(.*\/).*/\1/"`


wget --no-check-certificate -P "$path" -nc https://rrndb.umms.med.umich.edu/static/download/"$filename".zip

unzip -n -d "$path" "$target".zip

touch "$target"
