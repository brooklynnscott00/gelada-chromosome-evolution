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
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G

module load mamba/latest
source activate iqtree

mkdir -p iqtree_out
mkdir -p iqtree_out/results/

iqtree -s iqtree_out/results/iqtree_autosomes_pruned.varsites.phy -m MFP+ASC -B 1000 -alrt 1000 -nt 4 -o FIL009 -pre iqtree_out/results/iqtree_autosomes_pruned

