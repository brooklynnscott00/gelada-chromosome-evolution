#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="IM-autosomes"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=16

module purge
module load mamba/latest
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p Central-Southern_dadi-results
source scripts/_include_options.sh
 
dadi-cli InferDM --fs Central-Southern_dadi-fs/dadi.CEN.SOU.autosomes.noncoding.lowpass.folded.fs \
    --model IM \
    --nomisid \
    --lbounds 1e-7 1e-7 1e-2 1e-3 1e-10 1e-4 \
    --ubounds 1e-4 1e-4 10 10 1e-4 10 \
    --output dCentral-Southern_dadi-results/dadi.CEN.SOU.autosomes.noncoding.iso-with-migration.lowpass.demo.params \
    --force-convergence 128 \
    --cpus 16 \
    --coverage-model Central-Southern_dadi-fs/dadi.CEN.SOU.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22
