# README

Obtained files from rrnDB located at
https://rrndb.umms.med.umich.edu/static/download/

These are files from version 5.6, released in 2019.

We automated downloading the tsv file with wget
```
wget --no-check-certificate -P data/raw/ -nc
https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8.tsv.zip
unzip -n -d data/raw/ data/raw/rrnDB-5.8.tsv.zip

wget -nc -P data/raw/ --no-check-certificate
https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_16S_rRNA.fasta.zip
unzip -n -d data/raw/ data/raw/rrnDB-5.8_16S_rRNA.fasta.zip

wget -nc -P data/raw/ --no-check-certificate
https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip
unzip -n -d data/raw/ data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip


wget -nc -P data/raw/ --no-check-certificate
https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_pantaxa_stats_RDP.tsv.zip
unzip -n -d data/raw/ data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv.zip
```
