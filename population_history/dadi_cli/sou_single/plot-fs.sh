#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="plot frequecy spectrum"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/plots/

# assign chromosome number to slurm array ask ID

dadi-cli Plot --fs dadi_results/southern/${dataset}.southern.6.autosomes.noncoding.lowpass.folded.fs \
	--output dadi_results/plots/${dataset}.southern.autosomes.noncoding.lowpass.folded.fs.pdf
