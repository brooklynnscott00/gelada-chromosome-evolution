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

mkdir -p Northern-Central_dadi-results
source scripts/_include_options.sh
 
dadi-cli InferDM --fs Northern-Central_dadi-fs/dadi.NOR.CEN.autosomes.noncoding.folded.fs \
    --model IM \
    --nomisid \
    --lbounds 1e-2 1e-2 1e-2 1e-2 1e-2 1e-2 \
    --ubounds 0.99 0.99 0.99 0.99 0.99 0.99 \
    --output Northern-Central_dadi-results/dadi.NOR.CEN.autosomes.noncoding.IM.demo.params \
    --force-convergence 128 \
    --cpus 128 
