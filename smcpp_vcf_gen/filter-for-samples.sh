#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter gvcf for cohorts"
#SBATCH --output=out/slurm-%A_a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=public
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load bcftools-1.14-gcc-11.2.0

bcftools view --samples-file data/new_smcpp_list_cen-sou.txt -Oz -o vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.cen-sou.vcf.gz vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz
bcftools view --samples-file data/new_smcpp_list_nor-sou.txt -Oz -o vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.nor-sou.vcf.gz vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz


