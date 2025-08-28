#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="fs central"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/central

dadi-cli GenerateFs \
    --vcf vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
    --pop-info data/central.popfile.txt \
    --pop-ids CEN \
    --projections 22 \
    --output dadi_results/central/${dataset}.central.autosomes.noncoding.lowpass.folded.fs \
    --calc-coverage
