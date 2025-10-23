# VCF generation for demographic inference analysis

Scripts in this folder prepare vcf files for demographic analysis

```shell
$sbatch --time=7-00:00:00 DI-VCF-preprocessing/combine-gvcfs.sh
$sbatch --depend=afternotok:26032897 --array=1-2 DI-VCF-preprocessing/filter-gvcf-samples.sh
$sbatch --time=7-00:00:00 --array=1-2 DI-VCF-preprocessing/call-variants.sh
$sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh
```	




Creates new raw gvcf files with every single site that is callable

`sbatch --time=7-00:00:00 DI-VCF-preprocessing/dadi/combine-gvcf.northern-central.sh`	jobID: 33788585	**failed**
`sbatch --time=7-00:00:00 DI-VCF-preprocessing/dadi/combine-gvcf.northern-central.sh`	jobID: 33788776	**failed**
`sbatch --time=7-00:00:00 DI-VCF-preprocessing/dadi/combine-gvcf.northern-central.sh`	jobID: 33789109	**failed**
`sbatch --time=7-00:00:00 DI-VCF-preprocessing/dadi/combine-gvcf.northern-central.sh`	jobID: 33789478

`sbatch --time=7-00:00:00 DI-VCF-preprocessing/dadi/combine-gvcf.central-southern.sh`	jobID: 33788844	**failed**
`sbatch --time=7-00:00:00 DI-VCF-preprocessing/dadi/combine-gvcf.central-southern.sh`	jobID: 33789556 

`sbatch DI-VCF-preprocessing/dadi/subtract-paralogs.sh`	jobID: 34077701	**failed**
`sbatch DI-VCF-preprocessing/dadi/subtract-paralogs.sh`	jobID: 34078436


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



## filter VCF files for dadi PART 2

`sbatch --array=1-2 --time=2-00:00:00 DI-VCF-preprocessing/dadi/filter-vcfs.sh`	jobID: 33867951	**failed**
`sbatch --array=1-2 --time=2-00:00:00 DI-VCF-preprocessing/dadi/filter-vcfs.sh`	jobID: 33870120	**failed**
`sbatch --array=1-2 --time=2-00:00:00 DI-VCF-preprocessing/dadi/filter-vcfs.sh`	jobID: 33873033	**DONE**

## make low quality mask 
`sbatch --array=1-2 --time=4:00:00 DI-VCF-preprocessing/dadi/make-low-quality-mask.sh`	jobID: 33885068	**DONE**

```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' DI-vcf/dadi_2/dadi.tgel1.north_96.central_27.autosomes_only.pas_nofilter.low_quality_mask.bed
```
```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' DI-vcf/dadi_2/dadi.tgel1.central_27.southern_22.autosomes_only.pas_nofilter.low_quality_mask.bed
```





## get number of callable sites 

```shell
$sbatch --time=4:00:00 --mem=100G DI-VCF-preprocessing/make-low-quality-mask.sh
```

```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' DI-vcf/cen-sou.low_quality_mask.bed
```
46342647 sites

```shell
$awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' DI-vcf/nor-cen.low_quality_mask.bed
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

## filter for single population modelss

```shell
sbatch DI-VCF-preprocessing/subset-southern.sh
sbatch DI-VCF-preprocessing/subset-central.sh
sbatch DI-VCF-preprocessing/subset-north.sh
```

Identify paralogs in northern and central populations

```shell
$sbatch --array=1-3 DI-VCF-preprocessing/vcftools-hardy.sh	#jobID: 33066474

$awk 'NR==FNR {a[$1"\t"$2]=1; next} ($1"\t"$2 in a)' northern.high_het_sites_0.8.tsv central.high_het_sites_0.8.tsv > northern-central.common_high_het_sites_0.8.tsv

$wc -l northern-central.common_high_het_sites_0.8.tsv
42876

$awk 'NR==FNR {a[$1"\t"$2]=1; next} ($1"\t"$2 in a)' northern.high_het_sites_0.9.tsv central.high_het_sites_0.9.tsv > northern-central.common_high_het_sites_0.9.tsv

$wc -l northern-central.common_high_het_sites_0.9.tsv
35877

$awk 'NR==FNR {a[$1"\t"$2]=1; next} ($1"\t"$2 in a)' northern.high_het_sites_1.0.tsv central.high_het_sites_1.0.tsv > northern-central.common_high_het_sites_1.0.tsv

$wc -l northern.high_het_sites_1.0.tsv central.high_het_sites_1.0.tsv > northern-central.common_high_het_sites_1.0.tsv
23927
```

Remove paralogs from northern-central vcf

```shell
cut -f1,2 northern-central.common_high_het_sites_0.8.tsv > northern-central.common_high_het_sites_0.8.bed
```

`sbatch DI-VCF-preprocessing/nor-cen.subtract-paralogs.sh`	jobID: 33112506	**DONE**
`sbatch DI-VCF-preprocessing/nor-cen.subtract-paralogs.sh`	jobID: 33112562	**failed**
`sbatch DI-VCF-preprocessing/nor-cen.subtract-paralogs.sh`	jobID: 33112578	**failed**
`sbatch DI-VCF-preprocessing/nor-cen.subtract-paralogs.sh`	jobID: 33112678	**DONE**

`sbatch DI-VCF-preprocessing/cen-sou.subtract-paralogs.sh`	jobID: 33172709

Number of callable sites in north-central (577083394) - common heterozygous sites (42876) = 577040518
