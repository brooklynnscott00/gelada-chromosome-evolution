#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="central southern founder_asym simple"
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


dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model founder_asym \
    --nomisid \
    --lbounds 1e-5 1e-5 1e-5 1e-5 1e-5 \
    --ubounds 10 10 10 10 10 \
	--output-prefix dadi_results/cen_sou_simple/${dataset}.cen-sou.autosomes.noncoding.founder_asym.demo.params \
	--optimizations 20 \
	--force-convergence 100 \
	--cpus 4
