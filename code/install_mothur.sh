#!/usr/bin/env bash

# author: Affan
# inputs: None
# outputs: mothur installed in code/mothur
#
#
# the zip archive contains a directory called mothur so we contains
# extract it directory to code

# archive=$1

# dollar sign is good if there are spaces in file name
# single quotes will output $archive

# echo "$archive"


wget --no-check-certificate -P code/mothur/ -nc https://github.com/mothur/mothur/releases/download/v1.48.0/Mothur.OSX-10.14.zip

unzip -n -d code/ code/mothur/Mothur.OSX-10.14.zip