#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-nomig-size"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou

dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 -1 -1 -1 -1 -1 -1 \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-7 1e-8 1e-4 1e-1 1e-10 1e-3 \
    --ubounds 1e-4 1e-4 0.99 10 1e-6 0.99 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.no_mig_size.demo.params \
	--check-convergence 5 \
	--force-convergence 500 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 4
