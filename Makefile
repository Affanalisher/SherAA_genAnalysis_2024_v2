#!/usr/bin/env bash

# author: Affan
#
#
# Rule
# target : prerequisite1 prerequisite2 prerequisite3
#	(tab)recipe

# rule to install Mothur
code/mothur/mothur : code/install_mothur.sh
	code/install_mothur.sh


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
data/raw/rrnDB-5.8_16S_rRNA.align : code/align_sequences.sh\
													data/references/silva_seed/silva.seed_v138_1.align\
													data/raw/rrnDB-5.8_16S_rRNA.fasta\
													code/mothur/mothur
		./code/align_sequences.sh

# extract any region from the sequence, put it into a new directory and rename it
data/%/rrnDB.align data/%/rrnDB.bad.accnos : code/extract_region.sh\
													data/raw/rrnDB-5.8_16S_rRNA.align\
													code/mothur/mothur
		code/extract_region.sh $@

# rule to generate count table and a file containing unique sequences
data/%/rrnDB.unique.align data/%/data.count_table : code/count_unique_seqs.sh\
													data/%/rrnDB.align
													code/mothur/mothur
		code/count_unique_seqs.sh $@ # make sure you make count_unique_seqs.sh executable

#
# # extract v4 region from the sequence, put it into a new directory and rename it
# data/v4/rrnDB.align data/v4/rrnDB.bad.accnos : code/extract_region.sh\
# 												data/raw/rrnDB-5.8_16S_rRNA.align
# 		code/extract_region.sh $@
#
#
# # extract v34 region from the sequence, put it into a new directory and rename it
# data/v34/rrnDB.align data/v34/rrnDB.bad.accnos : code/extract_region.sh\
# 												data/raw/rrnDB-5.8_16S_rRNA.align
# 		code/extract_region.sh $@
