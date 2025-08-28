#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-nomig-size SOU CEN"
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

dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.6.22.autosomes.noncoding.lowpass.folded.fs \
    --bestfit-p0-file dadi_results/cen-sou/dadi.cen-sou.6.22.autosomes.noncoding.lowpass.no_mig_size.demo.params.InferDM.bestfits \
    --model no_mig_size \
    --nomisid \
    --delta-ll 0.005 \
    --lbounds 1e-10 1e-10 1e-3 1e-2 1e-15 1e-3 \
    --ubounds 1e-4 1e-4 100 1000 1e-9 100 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.6.22.autosomes.noncoding.lowpass.no_mig_size.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/${dataset}.cen-sou.6.22.autosomes.noncoding.lowpass.folded.fs.coverage.pickle \
	--cpus 4
