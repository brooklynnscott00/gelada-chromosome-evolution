#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make low quality mask"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G

module load bedtools2-2.30.0-gcc-11.2.0
module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p vcf

# northern and central
bcftools index vcf/nor-cen.quality-filtered.autosomes_only.vcf.gz

bcftools view -e 'FILTER="PASS"' DI-vcf/nor-cen.quality-filtered.autosomes_only.vcf.gz | \
  bcftools query -f '%CHROM\t%POS0\t%POS\n' > DI-vcf/nor-cen.low_quality_mask.bed
