#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run-dadi-DI-sym_mig"
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
mkdir -p dadi_results/cen-sou

dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 0.7505340443081098 18.009061899475363 0.14030037448281635 6.736930348692804 \
    --model sym_mig \
    --nomisid \
    --lbounds 1e-2 1e-1 1e-3 1e-2 \
    --ubounds 10 100 10 100 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.sym_mig.demo.params \
    --force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
    --grids 40 50 60 \
    --cpus 4

