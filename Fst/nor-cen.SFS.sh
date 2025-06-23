#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="SFS north and central"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=24

export PATH=$PATH:~/programs/angsd/misc/
source scripts/_include_options.sh

mkdir -p angsd-sfs/

realSFS angsd-saf/angsd-northern.saf.idx angsd-saf/angsd-central.saf.idx -fold 1 -P 24 > angsd-sfs/northern.central.ml

