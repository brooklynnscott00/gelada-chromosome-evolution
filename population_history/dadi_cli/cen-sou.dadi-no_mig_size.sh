#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-nomig-size"
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
    --p0 7.041749815893527e-05 5.74172413630268e-06 0.21186611274699285 3.936396844907854 7.486312764449154e-08 0.3296989171413364 \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-7 1e-8 1e-2 1e-1 1e-10 1e-2 \
    --ubounds 1e-4 1e-4 10 10 1e-6 110 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.no_mig_size.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
    --grids 40 50 60 \
	--cpus 4
