#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-repeats"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bedtools2-2.30.0-gcc-11.2.0
source scripts/_include_options.sh
mkdir -p vcf

vcfs="DI-vcf/cen-sou.quality-filtered.autosomes_only
DI-gvcf/cen-sou.cohort.autosomes_only.g
DI-vcf/nor-cen.quality-filtered.autosomes_only
DI-gvcf/nor-cen.cohort.autosomes_only.g"

vcf=$(echo "${vcfs}" | sed -n "${SLURM_ARRAY_TASK_ID}"p)

bedtools subtract -header \
	-a ${vcf}.vcf.gz \
	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
	${vcf}.rm_repeats.vcf

gzip ${vcf}.rm_repeats.vcf

