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

bcftools view -e 'ALT~"<"' -Ou iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.vcf.gz \
  | bcftools view -v snps -Ou \
  | bcftools norm -m -any -Ou \
  | bcftools view -m2 -M2 -c1 -Oz -o iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.snps_only.vcf.gz
