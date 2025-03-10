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
#SBATCH --cpus-per-task=128

module purge
module load mamba/latest
source activate /scratch/nsnyderm/conda_env/dadi-gpu

source scripts/_include_options.sh
 
dadi-cli InferDM --fs dadi_results/${dataset}_autosomes_noncoding.folded.fs \
    --model IM \
    --nomisid \
    --lbounds 1e-2 1e-2 1e-2 1e-2 1e-2 1e-2 \
    --ubounds 0.99 0.99 0.99 0.99 0.99 0.99 \
    --output dadi_results/${dadaset}_autosomes_noncoding_iso-with-migration.demo.params \
    --force-convergence 128 \
    --cpus 128
