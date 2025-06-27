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

# increase number of optimizations, convergence, and grid size for final run throughs

dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.0671 0.0867 10 0.1 0.006 0.0112 \
    --nomisid \
    --lbounds 1e-5 1e-5 1e-5 1e-5 1e-5 1e-5 \
    --ubounds 10 10 100 10 10 10 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--force-convergence 5 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 4
