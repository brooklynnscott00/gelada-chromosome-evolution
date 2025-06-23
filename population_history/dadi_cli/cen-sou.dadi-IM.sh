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
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou

dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.06706693742966094 0.08664027468416852 9.999997564626149 0.1 0.006136456067528904 0.011559302299622426 \
    --nomisid \
    --lbounds 1e-3 1e-3 1e-1 1e-3 1e-4 1e-3 \
    --ubounds 0.99 0.99 100 10 1e-1 0.99 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 16
