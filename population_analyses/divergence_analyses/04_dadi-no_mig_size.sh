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

finalfreqspec="data/dadi/fs_results/NOR.CEN.22.neutral_regions.folded.final.fs"

dadi-cli InferDM --fs ${finalfreqspec} \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-5 1e-8 1e-2 1e-2 1e-8 1e-3 \
    --ubounds 1e-3 1e-6 0.99 0.99 1e-6 1e-1 \
    --output /scratch/brscott4/gelada/data/dadi/demog_final/NOR.CEN.no_migration_size_change.neutral.demo.params \
    --force-convergence 128 \
    --cpus 16
