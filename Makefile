#!/usr/bin/env bash

# author: Affan
#
#
# Rule
# target : prerequisite1 prerequisite2 prerequisite3
#	(tab)recipe


# rule for downloading SILVA and data
data/references/silva_seed/silva.seed_v138_1.align : code/get_silva_seed.sh
	./code/get_silva_seed.sh


# rule for downloading rrnDB fasta file
# here we are giving the name of the file to the tabbed recipe
data/raw/rrnDB-5.8_16S_rRNA.fasta : code/get_rrndb_files.sh
	./code/get_rrndb_files.sh $@


# rule to download rest of rrnDB files
data/raw/rrnDB-5.8.tsv : code/get_rrndb_files.sh
	./code/get_rrndb_files.sh $@

data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv : code/get_rrndb_files.sh
	./code/get_rrndb_files.sh $@


data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv : code/get_rrndb_files.sh
	./code/get_rrndb_files.sh $@


# rule to align rrnDB fasta and SILVA Seed references
data/raw/rrnDB-5.8_16S_rRNA.align : data/references/silva_seed/silva.seed_v138_1.align\
													data/raw/rrnDB-5.8_16S_rRNA.fasta\
													code/align_sequences.sh
		./code/align_sequences.sh
