#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-asym_mig_size NOR CEN"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/nor-cen
mkdir -p dadi_results/nor-cen_2

dadi-cli InferDM --fs dadi_results/nor-cen/${dataset}.nor-cen.rm_common_high_het_sites_0.8.20.20.folded.sfs \
    --model asym_mig_size \
    --nomisid \
    --bestfit-p0-file dadi_results/nor-cen_2/dadi.nor-cen.20.20.autosomes.noncoding.rm_common_high_het_sites_0.8.asym_mig_size.demo.params.InferDM.bestfits \
    --lbounds 1e-2 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 1e-4 \
    --ubounds 1000000 1000 1000 1000 1000 1000 1000 1000 \
    --output-prefix dadi_results/nor-cen_2/${dataset}.nor-cen.20.20.autosomes.noncoding.rm_common_high_het_sites_0.8.asym_mig_size.demo.params \
    --force-convergence 100 \
    --cpus 4

