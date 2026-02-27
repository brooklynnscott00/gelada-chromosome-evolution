# VCF generation for demographic inference analysis

Scripts in this folder prepare vcf files for demographic analysis

## generate VCFs

```shell
$sbatch --time=7-00:00:00 DI-VCF-preprocessing/combine-gvcfs.sh
$sbatch --depend=afternotok:26032897 --array=1-3 DI-VCF-preprocessing/filter-gvcf-samples.sh
$sbatch --time=7-00:00:00 --array=1-3 DI-VCF-preprocessing/call-variants.sh
$sbatch --array=1-3 DI-VCF-preprocessing/quality-filter-variants.sh
```	
Combine gvcfs into a cohort file, filter for population specific samples (northern/central, central/southern, and northern/southern), call variants, quality filter variants


```shell
$sbatch --time=7-00:00:00 DI-VCF-preprocessing/combine-gvcf.northern-central.sh
```
Creates new raw gvcf files with every single site that is callable


```shell
$sbatch --mail-type=END --mail-type=ALL --time=12:00:00 --mem=32G --partition=general --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="bgzip cohort file 2" --cpus-per-task=8 --wrap="module load htslib-1.21-gcc-11.2.0; bgzip --threads 8 gvcf/nor-cen.cohort.g.vcf"
```

```shell
$sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/nor-cen.cohort.g.vcf.gz"
```
BGZIP and index cohort files for dadi analysis


```shell
$sbatch --array=1-3 DI-VCF-preprocessing/filter-for-autosomes.sh
$sbatch --array=1-2 DI-VCF-preprocessing/subtract-repeats.sh
$sbatch --array=1-2 DI-VCF-preprocessing/subtract-exons-10k-extended.sh
```
Filter to remove autosomes, repeats, and exons


## get number of callable sites

```shell
$sbatch DI-VCF-preprocessing/vcf2bed.sh
$sbatch --time=4:00:00 --mem=100G DI-VCF-preprocessing/make-low-quality-mask.sh
```
make a bed file with all the sites in the genome, and another with all sites that don't pass quality thresholds


```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' DI-vcf/nor-cen.low_quality_mask.bed
```
Count the number of low quality sites (1256515)


```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' gvcf/nor-cen.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed
```
Total number of sites (577083394)


```shell
$sbatch --array=1-3 DI-VCF-preprocessing/vcftools-hardy.sh

$awk 'NR==FNR {a[$1"\t"$2]=1; next} ($1"\t"$2 in a)' northern.high_het_sites_0.8.tsv central.high_het_sites_0.8.tsv > northern-central.common_high_het_sites_0.8.tsv

$wc -l northern-central.common_high_het_sites_0.8.tsv
```
Identify paralogs in northern and central populations and count the number of sites (42876)


```shell
$sbatch DI-VCF-preprocessing/nor-cen.subtract-paralogs.sh	
```
Remove paralogs from northern-central vcf

