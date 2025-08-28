# VCF generation for demographic inference analysis

Scripts in this folder prepare vcf files for demographic analysis

```shell
$sbatch --time=7-00:00:00 DI-VCF-preprocessing/combine-gvcfs.sh
$sbatch --depend=afternotok:26032897 --array=1-2 DI-VCF-preprocessing/filter-gvcf-samples.sh
$sbatch --time=7-00:00:00 --array=1-2 DI-VCF-preprocessing/call-variants.sh
$sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh
```	

```shell
$sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="bgzip cohort file 1" --wrap="module load htslib-1.21-gcc-11.2.0; bgzip gvcf/cen-sou.cohort.g.vcf"
$sbatch --mail-type=END --mail-type=ALL --time=12:00:00 --mem=32G --partition=general --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="bgzip cohort file 2" --cpus-per-task=8 --wrap="module load htslib-1.21-gcc-11.2.0; bgzip --threads 8 gvcf/nor-cen.cohort.g.vcf"
```

```shell
$sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/cen-sou.cohort.g.vcf.gz"
$sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/nor-cen.cohort.g.vcf.gz"
```


```shell
$sbatch --array=1 DI-VCF-preprocessing/filter-for-autosomes.sh
$sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh
$sbatch --array=1-4 DI-VCF-preprocessing/subtract-exons-10k-extended.sh
```

## get number of callable sites 

```shell
$sbatch --time=4:00:00 --mem=100G DI-VCF-preprocessing/make-low-quality-mask.sh
```

```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' vcf/cen-sou.low_quality_mask.bed
```
46342647 sites

```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' vcf/nor-cen.low_quality_mask.bed
```
1256515 sites

```shell
$sbatch DI-VCF-preprocessing/vcf2bed.sh
$sbatch DI-VCF-preprocessing/bedtools-merge-allsites.sh
$sbatch DI-VCF-preprocessing/make-neutral-regions-bed.sh
```

```shell
awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' gvcf/cen-sou.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed
```
Number of callable sites = 564856677

```shell
awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' gvcf/nor-cen.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed
```
Number of callable sites = 577083394

## filter for single population models

```shell
sbatch DI-VCF-preprocessing/subset-southern.sh
sbatch DI-VCF-preprocessing/subset-central.sh
```