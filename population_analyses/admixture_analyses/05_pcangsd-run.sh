#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="pcangsd"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=0

module load mamba/latest

source activate /data/CEM/smacklab/libraries/python/.conda/envs/angsd

mkdir -p stats/pcangsd

# pcangsd --beagle angsd_final/angsd_genolike_autosomes.beagle.gz --admix -o stats/ngsadmix/gelada --threads $SLURM_CPUS_ON_NODE

pcangsd --beagle angsd_final/angsd_genolike_autosomes.beagle.gz --out stats/pcangsd/gelada_thinned --threads 1

