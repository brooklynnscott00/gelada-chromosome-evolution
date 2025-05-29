#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run raxml"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8

module load raxml-8.2.12-gcc-12.1.0
source scripts/_include_options.sh

raxmlHPC -T 8 \
  -s RAxML/combined.phy \
  -n pop-tree.raxml \
  -m GTRGAMMA \
  -f a \
  -x 123 \
  -N 100 \
  -p 678
