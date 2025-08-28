#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="IM simple"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen_sou_simple


dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
    --nomisid \
    --lbounds 1e-5 1e-5 1e-5 1e-5 1e-8 1e-8 \
    --ubounds 100 100 100 100 1e-2 1e-2 \
	--output-prefix dadi_results/cen_sou_simple/${dataset}.cen-sou.autosomes.noncoding.IM.demo.params \
	--force-convergence 100 \
	--cpus 4
