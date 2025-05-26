#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-nomig"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=128

module load mamba/latest
source activate /data/CEM/smacklab/libraries/python/.conda/envs/dadi-cli-gpu

mkdir -p Northern-Central_dadi-results/
source scripts/_include_options.sh

dadi-cli InferDM --fs Northern-Central_dadi-fs/dadi.NOR.CEN.autosomes.noncoding.folded.fs \
    --model no_mig \
    --nomisid \
    --lbounds 1e-3 1e-2 1e-3 \
    --ubounds 0.99 0.99 0.99 \
    --output Northern-Central_dadi-results/dadi.NOR.CEN.autosomes.noncoding.no-migration.demo.params \
    --force-convergence 128 \
    --cpus 128 


