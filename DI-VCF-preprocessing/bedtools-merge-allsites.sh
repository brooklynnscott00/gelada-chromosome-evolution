#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="merge bed file"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=4G

module load bedtools2-2.30.0-gcc-11.2.0

bedtools merge -i DI-gvcf/cen-sou.cohort.autosomes_only.g.bed > DI-gvcf/cen-sou.cohort.autosomes_only.merged.g.bed
bedtools merge -i DI-gvcf/nor-cen.cohort.autosomes_only.g.bed > DI-gvcf/nor-cen.cohort.autosomes_only.merged.g.bed
