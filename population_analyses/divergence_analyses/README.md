# Scripts to run divergence time estimates

### Dadi analysis pipeline

##### Step 2 Get # of callable sites

`sbatch population_analyses/divergence_analyses/05_dadi-combine-gvcfs-1.sh`	jobID: 25388416	**DONE**
`sbatch population_analyses/divergence_analyses/05_dadi-combine-gvcfs-2.sh`	jobID: 25388441	**DONE**
Combine gvcfs from the cohort of animals that are used in dadi-cli analyses

`sbatch population_analyses/divergence_analyses/bedtools-make-low-quality-mask.sh`	jobID: 25497062	**DONE**
Make a low quality mask

(CONVERT THE VCF TO A BED FILE)
```shell
sbatch --time=4:00:00 --error=/scratch/brscott4/gelada-chromosome-evolution/out/slurm-%j.err --output=/scratch/brscott4/gelada-chromosome-evolution/out/slurm-%j.out --wrap="zcat dadi-cohort.NOR.CEN.g.vcf.gz | tail -n +15412 | awk '{FS=\"\t\";OFS=\"\t\"; print \$1, \$2-1, \$2}' > dadi-cohort.NOR.CEN.g.bed"

sbatch --time=4:00:00 --error=/scratch/brscott4/gelada-chromosome-evolution/out/slurm-%j.err --output=/scratch/brscott4/gelada-chromosome-evolution/out/slurm-%j.out --wrap="zcat dadi-cohort.CEN.SOU.g.vcf.gz | tail -n +15412 | awk '{FS=\"\t\";OFS=\"\t\"; print \$1, \$2-1, \$2}' > dadi-cohort.CEN.SOU.g.bed"
```
jobID: 25478445	**DONE**	
jobID: 25478453	**DONE**

(MERGE THE BED FILE)
`sbatch population_analyses/divergence_analyses/bedtools-merge-allsites.sh`	jobID: 25496926	**DONE**

`sbatch population_analyses/divergence_analyses/bedtools-make-neutral-regions-bed.sh`	jobID: 25499112	**DONE**
remove the low quality/repeats/exons 10k extended

```shell
l
```
number of callable sites in the neutral genome = this number doesn't match up with what I was using which is a little concering. 
Trying another methods before I do anythingelse 


(I THINK WE CAN DELETE ALL OF THE OTHER FILES BUT WAIT TO SEE )

`sbatch population_analyses/divergence_analyses/06_dadi-gatk-call-all-sites-1.sh`
`sbatch population_analyses/divergence_analyses/06_dadi-gatk-call-all-sites-2.sh`

`sbatch population_analyses/divergence_analyses/07_dadi-filter-allsitesVCF-autosomes-1.sh`
`sbatch population_analyses/divergence_analyses/07_dadi-filter-allsitesVCF-autosomes-2.sh`

`sbatch 08_dadi-filter-allsitesVCF-subtract_repeats.sh`

`sbatch 09_dadi-filter-allistesVCF-subtract_exons_10k_extended.sh`

```shell
zcat gvcf-dadi-combined/dadi.allsites.nogeno.autosomes.rm_repeats.rm_exons_10k_extended.vcf |tail -n +15352 |awk '{FS="\t";OFS="\t";print $1,$2-1,$2}' > gvcf-dadi-combined/dadi.allsites.nogeno.autosomes.rm_repeats.rm_exons_10k_extended.bed

# count number of callable sites in the genome, excluding repetitive regions and exons 10k extended
wc -l gvcf-dadi-combined/dadi.allsites.nogeno.autosomes.rm_repeats.rm_exons_10k_extended.bed

``` 





##### Step 3 Prepare SFS
`sbatch population_analyses/divergence_analyses/10_call-dadi-fs-2.sh`	jobID: 25541989	**DONE**
run dadi to GenerateFs in dadi format

`sbatch population_analyses/divergence_analyses/10_call-dadi-fs-2.sh`	jobID: 25613448	**failed**
`sbatch population_analyses/divergence_analyses/10_call-dadi-fs-2.sh`	jobID: 25614264	**DONE**
- again but this is the low pass version



##### Step 5 Bootstrapping
sbatch scripts/run-dadi-bootstrapping.sh


### SMC++ analysis pipeline

# run smcpp all regions again 
bedtools-subtract-callable-sites.sh = make inaccessible mask 
# convert vcfs to smc formt 
sbatch scripts/vcf2smc-CEN-all_regions.sh
jobID: 13938801 **DONE**
sbatch scripts/vcf2smc-NOR-all_regions.sh
jobID: 13938800 **DONE**
# estimation 
sbatch scripts/smcpp-estimate-CEN-all_regions.sh
jobID: 13938946 **DONE**
sbatch scripts/smcpp-estimate-NOR-all_regions.sh
jobID: 13938947 **DONE**
# joint fs 
sbatch scripts/vcf2smc-joint-fs-12-all_regions.sh
jobID: 13942934 **DONE**
sbatch scripts/vcf2smc-joint-fs-21-all_regions.s
jobID: 13942935 **DONE**
# split time
sbatch scripts/smcpp-split-all_regions.sh
jobID: 13943812 **DONE**


rsync brscott4@sol.asu.edu:/scratch/brscott4/gelada/smcpp/smcformat_whole_genome2/plot/joint.pdf ~/Desktop/joint-allRegions-2.pdf

# plot all regions again with generation time (no mask)
sbatch scripts/smcpp-plot-all_regions.sh
jobID: 14018554