# Make VCFs for demogrpahic inference analyses



BEFORE THIS WHOLE THING FINISHES I SHOULD CHANGE THE DIRCTORY NAME FROM `vcf` TO SOMETHING LIKE `DI-vcf`
mayu same for the gvcf directory so I don't get it confused with the long term gvcf storage in /CEM/smacklab/

`sbatch --depend=afternotok:25832966 --time=7-00:00:00 DI-VCF-preprocessing/combine-gvcfs.sh`	jobID: 25929071	**DONE**
Combine gvcf files to make a cohort gvcf of all animals who will be used for DI analysis 

`sbatch DI-VCF-preprocessing/filter-gvcf-samples.sh`	jobID: 26032884	**failed**
`sbatch DI-VCF-preprocessing/filter-gvcf-samples.sh`	jobID: 26032897	**timeout**
`sbatch --depend=afternotok:26032897 --array=1-2 DI-VCF-preprocessing/filter-gvcf-samples.sh`	jobID: 26044753	**DONE**
Filter the gvcf to get 2 cohort gvcfs to call variants from 

`sbatch --depend=afterok:26044753 --array=1-2 DI-VCF-preprocessing/call-variants.sh`	jobID: 26044769	**failed**
`sbatch --array=1-2 DI-VCF-preprocessing/call-variants.sh`	jobID: 26331645	**timeout**
`sbatch --time=7-00:00:00 --array=1-2 DI-VCF-preprocessing/call-variants.sh`	jobID: 26390310	**DONE**
Call variants 

Run quality filtering script for both CEN-SOU and CEN-NOR
`sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh`	jobID: 26450064	**DONE**


## bgzip the cohort file 

```shell
sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="bgzip cohort file 1" --wrap="module load htslib-1.21-gcc-11.2.0; bgzip gvcf/cen-sou.cohort.g.vcf"
```
jobID: 27631961	**DONE**

```shell
sbatch --mail-type=END --mail-type=ALL --time=12:00:00 --mem=32G --partition=general --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="bgzip cohort file 2" --cpus-per-task=8 --wrap="module load htslib-1.21-gcc-11.2.0; bgzip --threads 8 gvcf/nor-cen.cohort.g.vcf"
```
jobID: 27850052


## index the cohort file 
```shell
sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/cen-sou.cohort.g.vcf.gz"
```
jobID: 27818227	**DONE**

```shell
sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/nor-cen.cohort.g.vcf.gz"
```
jobID: 

## Filter for autosomes in the vcf and gvcf
`sbatch --array=1-2 DI-VCF-preprocessing/filter-for-autosomes.sh`	jobID: 27631084	**failed**
`sbatch --array=1-2 DI-VCF-preprocessing/filter-for-autosomes.sh`	jobID: 27631669


`remove repetitive regions`
`remove exons`
`low quality mask for dadi cohort file`
