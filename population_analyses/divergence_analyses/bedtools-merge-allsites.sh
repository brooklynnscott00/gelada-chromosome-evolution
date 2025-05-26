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
#SBATCH --mem=4G

module load bedtools2-2.30.0-gcc-11.2.0

bedtools merge -i gvcf-dadi-combined-1/dadi-cohort.NOR.CEN.g.bed > gvcf-dadi-combined-1/dadi-cohort.NOR.CEN.merged.g.bed
bedtools merge -i gvcf-dadi-combined-2/dadi-cohort.CEN.SOU.g.bed > gvcf-dadi-combined-2/dadi-cohort.CEN.SOU.merged.g.bed
