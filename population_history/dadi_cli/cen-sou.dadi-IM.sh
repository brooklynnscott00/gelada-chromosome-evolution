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
#SBATCH --cpus-per-task=16

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou

dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.01 0.173 0.99 0.04 0.01 0.16 \
    --nomisid \
    --lbounds 1e-3 1e-2 1e-2 1e-3 1e-3 1e-2 \
    --ubounds 0.99 0.99 10 1e-1 1e-1 0.99 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--check-convergence 5 \
	--force-convergence 500 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 16
