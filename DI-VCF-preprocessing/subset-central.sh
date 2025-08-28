#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter cen-sou vcf for central animals"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load bcftools-1.14-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p vcf

central='GUA001,GUA002,GUA003,FRZ001,FRZ002,FRZ003,FRZ004,FRZ005,FRZ006,FRZ007,FRZ009'

bcftools view -s ${central} -O z -o DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz DI-vcf/cen-sou.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz

