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

mkdir -p Northern-Central_dadi-results/
source scripts/_include_options.sh

dadi-cli InferDM --fs Northern-Central_dadi-fs/dadi.NOR.CEN.autosomes.noncoding.folded.fs \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-7 1e-8 1e-4 1e-1 1e-10 1e-3 \
    --ubounds 1e-4 1e-4 0.99 10 1e-6 0.99 \
    --output Northern-Central_dadi-results/dadi.NOR.CEN.autosomes.noncoding.no-mig-size.demo.params \
    --force-convergence 128 \
    --cpus 16
