#!/usr/bin/env bash

# author: Affan
# inputs: data/raw/rrnDB-5.8_16S_rRNA.fasta
#         data/references/silva_seed/silva.seed_v138_1.align
# outputs: data/raw/rrnDB-5.8_16S_rRNA.align
#
#
# we need to include flip=T to make sure all sequences are
# pointed in the same direction
#

# after < is file that goes in (can run without < too).
# after > is file that is outputed.
# g at the end of sed before closing quote means replace space with underscore
# globally.

sed "s/ /_/g" < data/raw/rrnDB-5.8_16S_rRNA.fasta > data/raw/rrnDB-5.8_16S_rRNA.temp.fasta

code/mothur/mothur '#align.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.temp.fasta, reference=data/references/silva_seed/silva.seed_v138_1.align, flip=T)'

if [[ $? -eq 0 ]]
then
  # rename the aligned file to remove temp
  mv data/raw/rrnDB-5.8_16S_rRNA.temp.align data/raw/rrnDB-5.8_16S_rRNA.align
  # remove the temp file
  rm data/raw/rrnDB-5.8_16S_rRNA.temp.fasta
else
  echo "FAIL: mothur failed to align sequences"
  exit 1
fi
