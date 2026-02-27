#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="fs-autosomes"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=26G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou
mkdir -p dadi_results/nor-cen

dadi-cli GenerateFs \
    --vcf DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf \
    --pop-info data/nor-cen.popfile.txt \
    --pop-ids NOR CEN \
    --projections 20 20 \
    --output dadi_results/dadi.nor-cen.rm_common_high_het_sites_0.8.20.20.folded.sfs \

