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

finalfreqspec="data/dadi/fs_results/NOR.CEN.22.neutral_regions.folded.final.fs"

dadi-cli InferDM --fs ${finalfreqspec} \
    --model no_mig \
    --nomisid \
    --lbounds 1e-2 1e-2 1e-2 \
    --ubounds 0.99 0.99 0.99 \
    --output /scratch/brscott4/gelada/data/dadi/demog_final/NOR.CEN.no_migration.neutral.demo.params \
    --force-convergence 128 \
    --cpus 128

