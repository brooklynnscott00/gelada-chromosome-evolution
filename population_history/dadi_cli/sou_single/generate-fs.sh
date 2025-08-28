#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="fs southern"
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
mkdir -p dadi_results/southern


dadi-cli GenerateFs \
    --vcf vcf/southern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
    --pop-info data/southern.popfile.txt \
    --pop-ids SOU \
    --projections 2 \
    --output dadi_results/southern/${dataset}.southern.2.autosomes.noncoding.lowpass.folded.fs \
    --calc-coverage

