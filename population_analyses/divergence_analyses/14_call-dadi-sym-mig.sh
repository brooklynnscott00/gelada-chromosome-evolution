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
#SBATCH --mem=64G
#SBATCH --cpus-per-task=128

module load mamba/latest
source activate /data/CEM/smacklab/libraries/python/.conda/envs/dadi-cli-gpu

source scripts/_include_options.sh


dadi-cli InferDM --fs dadi_results/${dataset}_autosomes_noncoding.folded.fs \
    --model sym_mig \
    --nomisid \
    --lbounds 1e-2 1e-2 1e-2 1e-2 \
    --ubounds 0.99 0.99 0.99 0.99 \
    --output dadi_results/${dadaset}_autosomes_noncoding_sym-mig.demo.params \
    --force-convergence 128 \
    --cpus 128

