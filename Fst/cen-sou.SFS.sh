#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="SFS central and south"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=150G
#SBATCH --cpus-per-task=24

export PATH=$PATH:~/programs/angsd/misc/
source scripts/_include_options.sh

mkdir -p angsd-sfs/

realSFS angsd-saf/angsd-central.saf.idx angsd-saf/angsd-southern.saf.idx -fold 1 -P 24 > angsd-sfs/central.southern.ml

