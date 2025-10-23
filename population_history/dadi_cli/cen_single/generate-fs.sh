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

haplotypes='20,18,16,14,12,10'
haplotype=$(echo "${haplotypes}" | cut -d',' -f${SLURM_ARRAY_TASK_ID})

mkdir -p dadi_results
mkdir -p dadi_results/central

dadi-cli GenerateFs \
    --vcf DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf.gz \
    --pop-info data/central.popfile.txt \
    --pop-ids CEN \
    --projections ${haplotype} \
    --output dadi_results/central/${dataset}.central.autosomes.${haplotype}.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs \
    --calc-coverage
