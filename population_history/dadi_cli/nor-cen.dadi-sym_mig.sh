#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-sym_mig"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/nor-cen

dadi-cli InferDM --fs dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.lowpass.folded.fs \
    --model sym_mig \
    --nomisid \
    --p0 0.19828690306129512 0.1434848538365765 0.6716388358380612 0.13015786537684146 \
    --lbounds 1e-2 1e-2 1e-3 1e-2 \
    --ubounds 10 100 10 100 \
    --output-prefix dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.sym_mig.demo.params \
    --check-convergence 5 \
    --force-convergence 500 \
    --cpus 4

