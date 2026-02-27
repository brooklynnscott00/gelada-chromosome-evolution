# Summary statistics and genotyping pipeline

Scripts in this folder perform genotypes from population resequncing data. These analyses begin with bam files that have already been mapped to the gelada reference genome. For mapping scripts refer to [Chiou et al. 2022](https://www.nature.com/articles/s41559-022-01703-4)

### bam summary statistics
```shell
$sbatch --time=4:00:00 --mem=24G --partition=htc --array=1-149 wgs_processing/run-mosdepth.sh
$sbatch --time=4:00:00 --mem=8G --partition=htc --array=1-149 wgs_processing/samtools-coverage.sh
$sbatch --array=1-149 wgs_processing/subset_bams.sh
```

### GATK Analysis pipeline

```shell
$sbatch --time=7-00:00:00 --array=1-149 wgs_processing/01_gatk-call.sh # 42414469,42414877,42588438
```

```shell
$sbatch --time=4:00:00 --array=1-947 wgs_processing/02_gatk-genotype.sh
$sbatch --time=4:00:00 --array=1-947 wgs_processing/02_gatk-genotype.sh
```
run gatk-genotype in parallel twice- this script is designed to be run over and over until every job (region) has successfully completed. It is expected that many jobs will fail the first time due to not completing both steps. Resubmitting will cause these jobs to resume starting with the second step only. 

```shell
$sbatch --time=4:00:00 wgs_processing/03_gatk-filter.sh
$sbatch --array=1-22 wgs_processing/04_bcftools-concat.sh
```
filter variants and concat

```shell
$sbatch --array=1-4 wgs_processing/05_bcftools-concat-final.sh
```

sbatch --array=1-22 wgs_processing/04_bcftools-concat.sh	jobID: 33797034	**DONE**

concatenate into autosomes and whole genome vcf

sbatch --array=5-6 wgs_processing/05_bcftools-concat-final.sh	jobID: 33788274	**failed**
sbatch --array=5-6 wgs_processing/05_bcftools-concat-final.sh	jobID: 33791494	**failed**
sbatch --array=5-6 wgs_processing/05_bcftools-concat-final.sh	jobID: 33795444	**failed**
sbatch --array=5-6 wgs_processing/05_bcftools-concat-final.sh	jobID: 33799367	**DONE**



sbatch --array=1 wgs_processing/05_bcftools-concat-final.sh	jobID: 44318399
sbatch --array=2-6 wgs_processing/05_bcftools-concat-final.sh	jobID: 44318431
sbatch --array=1-4 wgs_processing/05_bcftools-concat-final.sh	jobID: 44318655

### heterozygosity statistics
```shell
$sbatch --time=4:00:00 --mem=24G --partition=htc --array=1-21 wgs_processing/vcftools-het.sh
$sbatch --time=12:00:00 --mem=64G --partition=general --array=1,3,5,6,8,9,11,14 wgs_processing/vcftools-het.sh
$sbatch --time=24:00:00 --mem=64G --partition=general --array=14 wgs_processing/vcftools-het.sh
```
