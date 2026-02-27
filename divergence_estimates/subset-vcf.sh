#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter cen-sou vcf for central animals"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=16G

module load bcftools-1.14-gcc-11.2.0

northern_indvs=$(paste -sd, data/dadi.north_all.96.txt)
central_indvs=$(paste -sd, data/dadi.central_all.27.txt)

#cftools view --samples-file data/dadi.north_96.central_27.txt -Oz -o vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.central_27.vcf.gz vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz
bcftools view --samples-file data/dadi.north_all.96.txt -Oz -o vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.vcf.gz vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz
bcftools view --samples-file data/dadi.central_all.27.txt -Oz -o vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.central_27.vcf.gz vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz
