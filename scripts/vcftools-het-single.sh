#!/bin/bash

source scripts/_include_options.sh

window=$1
chr=$2

window_start=$(echo $window | cut -d : -f 2 | cut -d '-' -f 1)
window_end=$(echo $window | cut -d : -f 2 | cut -d '-' -f 2)
window_out=$(echo $window | sed -E 's/:/./g')

mkdir -p stats/vcftools-het-window

if [ ! -f stats/vcftools-het-window/${window_out}.het ] || [ $(wc -l < stats/vcftools-het-window/${window_out}.het) -ne 150 ]; then

vcftools --gzvcf vcf-chr/dadi.tgel1.bootstrap.chr${chr}.snv.vcf.gz \
	--het \
	--chr $chr \
	--from-bp $window_start \
	--to-bp $window_end \
	--out stats/vcftools-het-window/$window_out

fi
