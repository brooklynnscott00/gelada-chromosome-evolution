#!/bin/bash

i=$1
j=$2

source scripts/_include_options.sh

int=$(printf %04d $(grep -n $j data/tgel1_regions.txt | cut -d ':' -f 1))
chr=$(printf %02d $(grep -n $(echo $j | cut -d ':' -f 1) /data/CEM/smacklab/gelada_project/assemblies/tgel1/Tgel_1.0.dna.fa.fai | cut -d ':' -f 1))

mkdir -p bam

# echo /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${i}.aligned-tgel1.sorted.mkdups.bam ${j}
# echo sample_region_bams/${i}_${chr}.${int}.bam

if [[ ! -f "/data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${i}.aligned-tgel1.sorted.mkdups.bam" ]]; then
    echo "ERROR: BAM file not found" >&2
    exit 1
fi

samtools view -b /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${i}.aligned-tgel1.sorted.mkdups.bam ${j} > sample_region_bams/${i}_${chr}.${int}.bam
samtools index -b sample_region_bams/${i}_${chr}.${int}.bam
