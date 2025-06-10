#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make neutral regions bed"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G

cat gvcf/cen-sou.cohort.autosomes_only.g.vcf.gz | awk '!/^#/ {print $1, $2-1, $2}' OFS="\t" > gvcf/cen-sou.cohort.autosomes_only.g.bed
cat gvcf/nor-cen.cohort.autosomes_only.g.vcf.gz | awk '!/^#/ {print $1, $2-1, $2}' OFS="\t" > gvcf/nor-cen.cohort.autosomes_only.g.bed
