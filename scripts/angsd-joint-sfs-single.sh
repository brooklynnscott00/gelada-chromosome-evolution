#!/bin/bash

source scripts/_include_options.sh

population_pair=$1
chrom=$2

population1=$(echo "northern northern central" | cut -d " " -f $population_pair)
population2=$(echo "central southern southern" | cut -d " " -f $population_pair)

mkdir angsd-joint-sfs

realSFS \
	angsd-saf/${population1}/angsd-${population1}-${chrom}.saf.idx angsd-saf/${population2}/angsd-${population2}-${chrom}.saf.idx \
	-fold 1 \
	-P 24 > angsd-joint-sfs/${population1}-${population2}.${chrom}.ml

