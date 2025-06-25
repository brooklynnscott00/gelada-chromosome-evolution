#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-low-quality-regions"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load bedtools2-2.30.0-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0
module load tabix-2013-12-16-gcc-12.1.0 

mkdir -p smcpp_results
mkdir -p smcpp_results/nor-cen
mkdir -p smcpp_results/cen-sou

bedtools subtract -header \
	-a data/tgel1_autosomes.bed \
	-b vcf/nor-cen.low_quality_mask.bed > \
	smcpp_results/nor-cen/nor-cen.inaccessible-mask.bed

bedtools subtract -header \
	-a data/tgel1_autosomes.bed \
	-b vcf/cen-sou.low_quality_mask.bed > \
	smcpp_results/cen-sou/cen-sou.inaccessible-mask.bed

bgzip smcpp_results/nor-cen/nor-cen.inaccessible-mask.bed
bgzip smcpp_results/cen-sou/cen-sou.inaccessible-mask.bed

tabix -p bed smcpp_results/nor-cen/nor-cen.inaccessible-mask.bed.gz
tabix -p bed smcpp_results/cen-sou/cen-sou.inaccessible-mask.bed.gz
