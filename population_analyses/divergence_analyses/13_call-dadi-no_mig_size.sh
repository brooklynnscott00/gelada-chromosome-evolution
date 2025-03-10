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
#SBATCH --cpus-per-task=16

module load mamba/latest
source activate /data/CEM/smacklab/libraries/python/.conda/envs/dadi-cli-gpu

source scripts/_include_options.sh

dadi-cli InferDM --fs dadi_results/${dataset}_autosomes_noncoding.folded.fs \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-5 1e-8 1e-2 1e-2 1e-8 1e-3 \
    --ubounds 1e-3 1e-6 0.99 0.99 1e-6 1e-1 \
    --output dadi_results/${dadaset}_autosomes_noncoding_no-mig-size.demo.params \
    --force-convergence 128 \
    --cpus 16
