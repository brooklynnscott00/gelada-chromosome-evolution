#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="extract protein IDs"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=164G
#SBATCH --export=NONE

central_gtf="/scratch/nsnyderm/tgel_ncbi/tgel_central/complete.genomic.gtf"
northern_gtf

# Genome 1: chr7
awk '$1=="7" && $3=="CDS"' ${central_gtf} \
  | grep -o 'protein_id "[^"]*"' \
  | cut -d\" -f2 \
  | sort -u > genome1_chr7_proteins.txt

# Genome 2: chrA and chrB
awk '($1=="A" || $1=="B") && $3=="CDS"' genome2.gtf \
  | grep -o 'protein_id "[^"]*"' \
  | cut -d\" -f2 \
  | sort -u > genome2_chrAB_proteins.txt


