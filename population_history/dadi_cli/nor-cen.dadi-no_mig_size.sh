#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-nomigsize"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=4
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/nor-cen

dadi-cli InferDM --fs dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.lowpass.folded.fs \
    --model no_mig_size \
    --nomisid \
    --p0 1.3806424180040722e-06 1.003394540411702e-08 0.062424504502346545 0.2846462213802358 6.516641410323098e-09 0.02602514468755817 \
    --lbounds 1e-8 1e-9 1e-4 1e-2 1e-11 1e-3 \
    --ubounds 1e-4 1e-7 0.99 10 1e-8 0.99 \
    --optimizations 10 \
    --output-prefix dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.no_mig_size.demo.params \
    --force-convergence 50 \
    --cpus 4
