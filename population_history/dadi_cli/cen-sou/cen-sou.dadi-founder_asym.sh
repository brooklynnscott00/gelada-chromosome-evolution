#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="founder_asym-autosomes SOU CEN"
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
mkdir -p dadi_results/cen-sou
mkdir -p dadi_results/cen-sou_2

dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.rm_common_high_het_sites_0.8.20.6.lowpass.folded.fs \
	--model founder_asym \
    --nomisid \
	--bestfit-p0-file dadi_results/cen-sou_2/dadi.cen-sou.autosomes.20.6.noncoding.rm_common_high_het_sites_0.8.lowpass.founder_asym.demo.params.InferDM.bestfits \
	--delta-ll 0.005 \
    --lbounds 1e-10 1e-10 1e-10 1e-10 1e-10 \
    --ubounds 100 100 100 100 100 \
	--output-prefix dadi_results/cen-sou_2/${dataset}.cen-sou.autosomes.20.6.noncoding.rm_common_high_het_sites_0.8.lowpass.founder_asym.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.rm_common_high_het_sites_0.8.20.6.lowpass.folded.fs.coverage.pickle \
	--cpus 4
