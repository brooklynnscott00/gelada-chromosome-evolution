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
#SBATCH --cpus-per-task=4

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/nor-cen

dadi-cli InferDM --fs dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.lowpass.folded.fs \
    --model no_mig \
    --nomisid \
    --lbounds 1e-3 1e-2 1e-3 \
    --ubounds 0.99 0.99 0.99 \
    --output-prefix dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.no_mig.demo.params \
    --check-convergence 5 \
    --force-convergence 500 \
    --cpus 4

