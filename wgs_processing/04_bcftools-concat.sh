#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="chr"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=4G

source scripts/_include_options.sh

chr=$(cut -d ':' -f 1 data/${genome}_regions.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p)
chr_print=$(printf %02d $chr 2> >(grep -v 'invalid number'))

if [ $chr_print = "00" ]; then
chr_out=$chr
chr_print=$chr
else
chr_out=$chr_print
fi 

# awk -F ':' '{ if ($1 == "'${chr}'") { print $1":"$2 }}' data/${genome}_regions.txt

mkdir -p vcf-chr

# module load bcftools-1.14-gcc-11.2.0
# module load htslib/1.15.1

module load bcftools/1.15.1
module load htslib/1.15.1

# pass genotyping and quality filters
bcftools concat -Oz -o vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.pas.vcf.gz $(for i in $(grep --color=none -nE '^'${chr}':' data/${genome}_regions.txt | cut -d ':' -f 1); do echo vcf-split/${dataset}.${genome}.bootstrap.region.$(printf "%04d" $i | xargs).chr${chr_print}.pas.vcf.gz; done)

tabix -p vcf vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.pas.vcf.gz

# no quality filters
bcftools concat -Oz -o vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.snv.vcf.gz $(for i in $(grep --color=none -nE '^'${chr}':' data/${genome}_regions.txt | cut -d ':' -f 1); do echo vcf-split/${dataset}.${genome}.bootstrap.region.$(printf "%04d" $i | xargs).chr${chr_print}.snv.vcf.gz; done)

tabix -p vcf vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.snv.vcf.gz
