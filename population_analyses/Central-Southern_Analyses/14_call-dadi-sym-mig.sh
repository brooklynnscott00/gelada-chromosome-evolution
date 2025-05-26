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
#SBATCH --cpus-per-task=16

module load mamba/latest
source activate /data/CEM/smacklab/libraries/python/.conda/envs/dadi-cli-gpu

mkdir -p Central-Southern_dadi-fs/
source scripts/_include_options.sh

dadi-cli InferDM --fs Central-Southern_dadi-fs/dadi.CEN.SOU.autosomes.noncoding.lowpass.folded.fs \
    --model sym_mig \
    --nomisid \
    --lbounds 1e-2 1e-1 1e-3 1e-2 \
    --ubounds 10 100 10 100 \
    --output Central-Southern_dadi-results/dadi.CEN.SOU.autosomes.noncoding.sym-mig.demo.params \
    --force-convergence 128 \
    --cpus 16 \
    --coverage-model Central-Southern_dadi-results/dadi.CEN.SOU.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22
