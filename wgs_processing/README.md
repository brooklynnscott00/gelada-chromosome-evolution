# Summary statistics and genotyping pipeline

Scripts in this folder perform genotypes from population resequncing data. These analyses begin with bam files that have already been mapped to the gelada reference genome. For mapping scripts refer to [Chiou et al. 2022](https://www.nature.com/articles/s41559-022-01703-4)

### bam summary statistics
```shell
$sbatch --time=4:00:00 --mem=24G --partition=htc --array=1-149 wgs_processing/run-mosdepth.sh
$sbatch --time=4:00:00 --mem=8G --partition=htc --array=1-149 wgs_processing/samtools-coverage.sh
```
 
### GATK Analysis pipeline

```shell
$sbatch --time=7-00:00:00 --array=1-149 wgs_processing/01_gatk-call.sh
```
run gatk in parallel to call variants for each sample 

```shell
$sbatch --time=4:00:00 --array=1-947 wgs_processing/02_gatk-genotype.sh   
$sbatch --time=4:00:00 --array=1-947 wgs_processing/02_gatk-genotype.sh
```
run gatk-genotype in parallel twice- this script is designed to be run over and over until every job (region) has successfully completed. It is expected that many jobs will fail the first time due to not completing both steps. Resubmitting will cause these jobs to resume starting with the second step only. 

```shell
$sbatch wgs_processing/03_gatk-filter.sh
$sbatch --array=1-22 wgs_processing/04_bcftools-concat.sh
```
filter variants and concat

```shell
$sbatch --array=1-4 wgs_processing/05_bcftools-concat-final.sh
```
concatenate into autosomes and whole genome vcf

### heterozygosity statistics
```shell
$sbatch --time=4:00:00 --mem=24G --partition=htc --array=1-21 wgs_processing/vcftools-het.sh
$sbatch --time=12:00:00 --mem=64G --partition=general --array=1,3,5,6,8,9,11,14 wgs_processing/vcftools-het.sh
$sbatch --time=24:00:00 --mem=64G --partition=general --array=14 wgs_processing/vcftools-het.sh
```
