#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-repeats"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bcftools-1.14-gcc-11.2.0

source scripts/_include_options.sh

# define dadi sample list
samples='data/dadi-sample_list.txt'

chr=$(cut -d ':' -f 1 data/${genome}_regions.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p)
chr_print=$(printf %02d $chr 2> >(grep -v 'invalid number'))

if [ $chr_print = "00" ]; then
chr_out=$chr
chr_print=$chr
else
chr_out=$chr_print
fi 

mkdir -p dadi-vcf-chr/
mkdir -p dadi-vcf/

# filter vcfs for only the samples inlcuded in the dadi list
bcftools view -S ${samples} vcf-chr/${dataset}.${genome}.bootstrap.chr${chr_out}.pas.vcf.gz > dadi-vcf-chr/${dataset}.NOR.CEN.22.chr${chr_out}.pas.vcf.gz

# concat and index
if [ "$SLURM_ARRAY_TASK_ID" -eq 22 ]; then
	ls dadi-vcf-chr/*.vcf.gz | sort -V > data/dadi_vcf_list.txt
	bcftools concat -Oz -o dadi-vcf/${dataset}.NOR.CEN.22.merged.vcf.gz -f data/${dataset}_vcf_list.txt
	bcftools index dadi-vcf/${dataset}.NOR.CEN.22.merged.vcf.gz
fi

