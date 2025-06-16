#!/bin/bash

source scripts/_include_options.sh

POPULATION=$1
CHROM=$2

echo "Running ANGSD for group $POPULATION on chromosome $CHROM"

mkdir angsd-saf/${POPULATION}

angsd \
  -b data/bam-lists/${POPULATION}.txt \
  -anc /scratch/brscott4/gelada/data/genome/${genome_path} \
  -out angsd-saf/${POPULATION}/angsd-${POPULATION}-${CHROM} \
  -dosaf 1 \
  -gl 1 \
  -r ${CHROM}
