#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="SFS north and central"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=4

export PATH=$PATH:~/programs/angsd/
source scripts/_include_options.sh

mkdir -p angsd-sfs/

angsd realSFS angsd-saf/angsd-northern.saf.idx angsd-saf/angsd-central.saf.idx -P 24 > angsd-sfs/northern.central.ml

