#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter nor-cen vcf for northern animals"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load bcftools-1.14-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p DI-vcf

northern='CHK001,CHK002,CHK003,SKR005,SKR007,SKR010,SKR013,SKR022,SKR030,SKR038,SKR039'

bcftools view -s ${northern} -O z -o DI-vcf/northern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz

