#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-paralogs"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load vcftools-0.1.14-gcc-11.2.0
module load htslib-1.16-gcc-11.2.0
source scripts/_include_options.sh
mkdir -p DI-vcf/

# vcftools --gzvcf DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
# 	--recode \
# 	--out DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8 \
# 	--exclude-positions DI-vcf/northern-central.common_high_het_sites_0.8.tsv \
# 
# mv DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.recode.vcf DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf
# bgzip DI-vcf/nor-cen.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf

vcftools --gzvcf DI-vcf/northern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
	--recode \
	--out DI-vcf/northern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8 \
	--exclude-positions DI-vcf/northern-central.common_high_het_sites_0.8.tsv \

mv DI-vcf/northern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.recode.vcf DI-vcf/northern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf
bgzip DI-vcf/northern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf

vcftools --gzvcf DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
	--recode \
	--out DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8 \
	--exclude-positions DI-vcf/northern-central.common_high_het_sites_0.8.tsv \

mv DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.recode.vcf DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf
bgzip DI-vcf/central.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.rm_common_high_het_sites_0.8.vcf
