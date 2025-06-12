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
jobID: 27850052	**DONE**


## index the cohort file 
```shell
sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/cen-sou.cohort.g.vcf.gz"
```
jobID: 27818227	**DONE**

```shell
sbatch --mail-type=END --mail-type=ALL --time=4:00:00 --mem=32G --partition=htc --output=out/slurm-%j.out --error=out/slurm-%j.err --mail-user=brscott4@asu.edu --job-name="index cohort file 1" --wrap="module load bcftools-1.14-gcc-11.2.0; bcftools index gvcf/nor-cen.cohort.g.vcf.gz"
```
jobID: 27896064	**DONE**

## Filter for autosomes in the vcf and gvcf
`sbatch --array=1-2 DI-VCF-preprocessing/filter-for-autosomes.sh`	jobID: 27972003	**DONE**
`sbatch --array=1 DI-VCF-preprocessing/filter-for-autosomes.sh`	jobID: 27978515	**failed**
`sbatch --array=1 DI-VCF-preprocessing/filter-for-autosomes.sh`	jobID: 27978561	**DONE**


mv gvcf/cen-sou.cohort.autosomes_only.g.vcf gvcf/cen-sou.cohort.autosomes_only.g.vcf.gz
mv gvcf/nor-cen.cohort.autosomes_only.g.vcf gvcf/nor-cen.cohort.autosomes_only.g.vcf.gz

`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27978238	**failed**
`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27978267	**failed**
`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27978321	**failed**
`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27978372	**failed**
`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27979395	**failed**
`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27979447	**failed**
`sbatch --array=1-4 DI-VCF-preprocessing/subtract-repeats.sh`	jobID: 27983093	**DONE**

`sbatch --array=1-4 DI-VCF-preprocessing/subtract-exons-10k-extended.sh`	jobID: 27993535	**DONE**

Might want to remove all the cohorot stuff from the above scripts and only do these for the VCFs and not the gVCFs ^^
Seems like it wasn't working properly
Want to try to re-do those step below 

`sbatch DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 27993823	**OOM**
`sbatch DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 27993944	**OOM**
`sbatch --mem=128G DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 27994669	**OOM**	
`sbatch --mem=400G DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 27994950	**failed**
`sbatch --mem=400G DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 27995632	**failed**
`sbatch --mem=400G DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 28001396	**DONE**
`sbatch --mem=400G DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 28053502	**timeout**
`sbatch --time=4:00:00 --mem=100G DI-VCF-preprocessing/make-low-quality-mask.sh`	jobID: 28059818



`sbatch DI-VCF-preprocessing/vcf2bed.sh`	jobID: 27994705	**DONE**

`sbatch DI-VCF-preprocessing/bedtools-merge-allsites.sh`	jobID: 28001417	**DONE**

`sbatch DI-VCF-preprocessing/make-neutral-regions-bed.sh`	jobID: 28016580	**failed**
`sbatch DI-VCF-preprocessing/make-neutral-regions-bed.sh`	jobID: 28016619	**DONE**

```shell
awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' gvcf/cen-sou.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed
```
Number of callable sites = 577244838

```shell
awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' gvcf/nor-cen.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed
```
Number of callable sites = 
