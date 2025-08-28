#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="central southern nomig size simple"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou

dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-7 1e-8 1e-2 1e-1 1e-10 1e-2 \
    --ubounds 1e-4 1e-4 10 10 1e-6 110 \
    --output-prefix dadi_results/cen_sou_simple/${dataset}.cen-sou.autosomes.noncoding.no_mig_size.demo.params \
	--force-convergence 100 \
	--cpus 4
