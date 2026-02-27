#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter-vcf"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=64G

module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0
module load vcftools-0.1.14-gcc-11.2.0

mkdir -p iqtree_out
mkdir -p iqtree_out/vcf

bcftools merge iqtree_out/vcf/vcf1.autosomes.pas.snps.vcf.gz iqtree_out/vcf/vcf2.autosomes.pas.snps.vcf.gz -Oz -o iqtree_out/vcf/merged.autosomes.vcf.gz
tabix -p vcf iqtree_out/vcf/merged.autosomes.vcf.gz

vcftools --gzvcf iqtree_out/vcf/merged.autosomes.vcf.gz \
	--max-missing 0.8 \
	--thin 10000 \
	--recode --recode-INFO-all \
	--out iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k
	
bgzip iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.recode.vcf
mv iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.recode.vcf.gz iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.vcf.gz
tabix -p vcf iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.vcf.gz


