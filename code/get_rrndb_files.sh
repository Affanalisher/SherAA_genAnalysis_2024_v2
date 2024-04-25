#!/usr/bin/env bash

# author: Affan
# inputs: Name of the file extracted from the archive without the path
# outputs: the appropriate rrnDB files into data/raw

archive=$1

# dollar sign is good if there are spaces in file name
# single quotes will output $archive

# echo "$archive"


wget --no-check-certificate -P data/raw/ -nc https://rrndb.umms.med.umich.edu/static/download/"$archive".zip

unzip -n -d data/raw/ data/raw/"$archive".zip
