#!/bin/bash

# Read in first argument and assign a more readable variable name
line_number=$1

input_file_path=$(cut -f 3 data/sample_region_list_final.txt | sed -n ${line_number}p)
sample_name=$(cut -f 2 data/sample_region_list_final.txt | sed -n ${line_number}p)
chr=$(cut -f 1 -d : data/sample_region_list_final.txt | sed -n ${line_number}p)
region=$(cut -f 2 -d : data/sample_region_list_final.txt | cut -f 1 | sed -n ${line_number}p)

mkdir -p sample_region_bams

samtools view \
        -o sample_region_bams/${sample_name}_${chr}.${region}.bam -hb $input_file_path \
        ${chr}:${region}
