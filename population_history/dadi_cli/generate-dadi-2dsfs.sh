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
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load htslib-1.21-gcc-11.2.0
module load mamba/latest

source scripts/_include_options.sh
source activate /scratch/nsnyderm/conda_env/dadi-gpu

mkdir -p dadi_results
mkdir -p dadi_results/cen-sou
mkdir -p dadi_results/nor-cen

# dadi-cli GenerateFs \
#     --vcf DI-vcf/cen-sou.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
#     --pop-info data/cen-sou.popfile.txt \
#     --pop-ids CEN SOU \
#     --projections 20 6 \
#     --output dadi_results/cen-sou/${dataset}.cen-sou.20.6.autosomes.noncoding.lowpass.folded.fs \
#     --calc-coverage

dadi-cli GenerateFs \
    --vcf DI-vcf/cen-sou.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf.gz \
    --pop-info data/cen-sou.popfile.txt \
    --pop-ids CEN SOU \
    --projections 20 6 \
    --output dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.rm_common_high_het_sites_0.8.20.6.lowpass.folded.fs \
    --calc-coverage

# dadi-cli GenerateFs \
#     --vcf DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
#     --pop-info data/nor-cen.popfile.txt \
#     --pop-ids NOR CEN \
#     --projections 22 22 \
#     --output dadi_results/nor-cen/${dataset}.nor-cen.autosomes.noncoding.lowpass.folded.fs \
#     --calc-coverage

# dadi-cli GenerateFs \
#     --vcf DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf.gz \
#     --pop-info data/nor-cen.popfile.txt \
#     --pop-ids NOR CEN \
#     --projections 20 20 \
#     --output dadi_results/nor-cen/${dataset}.nor-cen.rm_common_high_het_sites_0.8.20.20.folded.sfs \
#     --calc-coverage
