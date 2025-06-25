#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="founder_asym-autosomes"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=16
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou

# 5 params 
# s , nu2, T, m12, m21
# increase optimiza

dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model founder_asym \
	--p0 -1 -1 -1 \
    --nomisid \
    --lbounds 1e-3 1e-3 1e-3 1e-3 1e-3 \
    --ubounds 0.99 0.99 0.99 0.99 0.99 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.founder_asym.demo.params \
	--optimizations 20 \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 16
