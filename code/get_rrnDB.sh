#!/usr/bin/env bash

# author: Affan
# inputs: none
# outputs: rrndb-5.8_16S_rRNA.fasta into data/raw


wget -nc -P data/raw/ --no-check-certificate https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_16S_rRNA.fasta.zip

unzip -n -d data/raw/ data/raw/rrnDB-5.8_16S_rRNA.fasta.zip
