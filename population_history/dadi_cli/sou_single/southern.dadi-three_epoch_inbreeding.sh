#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="southern three_epoch_inbreeding"
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
mkdir -p dadi_results/southern 


dadi-cli InferDM --fs dadi_results/southern/${dataset}.southern.6.autosomes.noncoding.lowpass.folded.fs \
	--model three_epoch_inbreeding \
    --nomisid \
	--delta-ll 0.005 \
	--bestfit-p0-file dadi_results/southern/dadi.southern.6.autosomes.noncoding.lowpass.three_epoch_inbreeding.demo.params.InferDM.bestfits \
    --lbounds 1e-8 1e-6 1e-7 1e-8 1e-8 \
    --ubounds 1e-2 10 10 1e-2 1e-2 \
	--output-prefix dadi_results/southern/${dataset}.southern.6.autosomes.noncoding.lowpass.three_epoch_inbreeding.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/southern/dadi.southern.6.autosomes.noncoding.lowpass.folded.fs.coverage.pickle \
	--cpus 4
