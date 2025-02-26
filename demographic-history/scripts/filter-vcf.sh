

module load bcftools-1.14-gcc-11.2.0

bcftools view --apply-filters .,PASS results/dadi-cohort.quality_filtered.vcf.gz -m2 -M2 --genotype ^miss --include 'TYPE="snp"' --output-type z --output-file results/dadi-cohort.quality_filtered.pass.biallelic.rm_missing.vcf.gz

