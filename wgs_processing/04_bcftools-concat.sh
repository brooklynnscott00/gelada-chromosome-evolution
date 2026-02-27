#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="chr"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --export=NONE

source scripts/_include_options.sh

chr=$(cut -d ':' -f 1 data/tgel1_regions.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p)
chr_print=$(printf %02d $SLURM_ARRAY_TASK_ID)

if [ $chr_print = "00" ]; then
chr_out=$chr
chr_print=$chr
else
chr_out=$chr_print
fi 

mkdir -p vcf-chr
mkdir -p vcf-chr-2

module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

# pass genotyping and quality filters
bcftools concat -Oz -o vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.pas.vcf.gz $(for i in $(grep --color=none -nE '^'${chr}':' data/${genome}_regions.txt | cut -d ':' -f 1); do echo vcf-split/${dataset}.${genome}.bootstrap.region.$(printf "%04d" $i | xargs).chr${chr_print}.pas.vcf.gz; done)
bcftools sort -Oz -o vcf-chr/${dataset}.tgel1.bootstrap.chr${chr_out}.pas.sorted.vcf.gz vcf-chr/${dataset}.tgel1.bootstrap.chr${chr_out}.pas.vcf.gz
tabix -p vcf vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.pas.sorted.vcf.gz

#no quality filters
bcftools concat -Oz -o vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.snv.vcf.gz $(for i in $(grep --color=none -nE '^'${chr}':' data/${genome}_regions.txt | cut -d ':' -f 1); do echo vcf-split/${dataset}.${genome}.bootstrap.region.$(printf "%04d" $i | xargs).chr${chr_print}.snv.vcf.gz; done)
bcftools sort -Oz -o vcf-chr/${dataset}.tgel1.bootstrap.chr${chr_out}.snv.sorted.vcf.gz vcf-chr/${dataset}.tgel1.bootstrap.chr${chr_out}.snv.vcf.gz
tabix -p vcf vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.snv.sorted.vcf.gz

#mkdir -p vcf-list
#ls vcf-split/*${chr_print}*pas_nofitler.vcf.gz > gvcf-list/${id}-region-list.txt

#if [ "$(wc -l < gvcf-list/${id}-region-list.txt)" -eq 947 ]; then

# bcftools concat -Oz -o vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.pas_nofilter.vcf.gz $(for i in $(grep --color=none -nE '^'${chr}':' data/tgel1_regions.txt | cut -d ':' -f 1); do echo vcf-split/${dataset}.tgel1.bootstrap.region.$(printf "%04d" $i | xargs).chr${chr_print}.pas_nofilter.vcf.gz; done)
# bcftools sort -Oz -o vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.pas_nofilter.sorted.vcf.gz vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.pas_nofilter.vcf.gz
# tabix -p vcf vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.pas_nofilter.sorted.vcf.gz
# 
# bcftools concat -Oz -o vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.snv_nofilter.vcf.gz $(for i in $(grep --color=none -nE '^'${chr}':' data/tgel1_regions.txt | cut -d ':' -f 1); do echo vcf-split/${dataset}.tgel1.bootstrap.region.$(printf "%04d" $i | xargs).chr${chr_print}.snv_nofilter.vcf.gz; done)
# bcftools sort -Oz -o vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.snv_nofilter.sorted.vcf.gz vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.snv_nofilter.vcf.gz
# tabix -p vcf vcf-chr-2/${dataset}.tgel1.bootstrap.chr${chr_out}.snv_nofilter.sorted.vcf.gz

