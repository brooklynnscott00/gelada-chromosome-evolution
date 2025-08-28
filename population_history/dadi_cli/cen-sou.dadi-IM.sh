#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="IM-autosomes"
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
mkdir -p dadi_results/cen-sou
mkdir -p dadi_results/cen-sou/IM_1


dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.6.22.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--bestfit-p0-file dadi_results/cen-sou/dadi.cen-sou.autosomes.6.22.noncoding.lowpass.IM.demo.params.InferDM.bestfits \
    --nomisid \
	--delta-ll 0.005 \
    --lbounds 1e-12 1e-12 1e-7 1e-12 1e-12 1e-8 \
    --ubounds 1e-4 1e-4 10 1e-2 1e-2 1e-2 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.6.22.noncoding.lowpass.IM.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/${dataset}.cen-sou.6.22.autosomes.noncoding.lowpass.folded.fs.coverage.pickle \
	--cpus 4
