#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="IM simulation"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/simulation


dadi-cli SimulateDM --model IM \
	--sample-sizes 22 22 \
	--p0 0.8767294385890955 0.10916525720421913 0.19265660769495646 0.1544574272198836 0.7063421048165879 0.6973761940342879 \
	--nomisid \
	--output dadi_results/simulation/IM.simDM.fs
