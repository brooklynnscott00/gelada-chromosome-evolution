# Scripts to run divergence time estimates

### Dadi analysis pipeline

##### Step 1 Prepare input VCF

`sbatch --array=1-22 01_dadi-make-vcf.sh` make a vcf with subset of animals that will be included in the dadi analysis
`sbatch 02_dadi-filter-vcf-autosomes.sh` filter vcf to remove X chromsome
`sbatch 03_dadi-filter-vcf-subtract_repeats.sh` 
`sbatch 04_dadi-filter-vcf-subtract_exons_10k_extended` 

##### Step 2 Get # of callable sites

`sbatch 05_dadi-combine-gvcfs.sh` Combine gvcfs from the cohort of animals that are used in dadi-cli analyses
`sbatch 06_dadi-gatk-call-all-sites.sh`
`sbatch 07_dadi-filter-allsitesVCF-autosomes.sh`
`sbatch 08_dadi-filter-allsitesVCF-subtract_repeats.sh`
`sbatch 09_dadi-filter-allistesVCF-subtract_exons_10k_extended.sh`

```shell
zcat gvcf-dadi-combined/dadi.allsites.nogeno.autosomes.rm_repeats.rm_exons_10k_extended.vcf |tail -n +15352 |awk '{FS="\t";OFS="\t";print $1,$2-1,$2}' > gvcf-dadi-combined/dadi.allsites.nogeno.autosomes.rm_repeats.rm_exons_10k_extended.bed

# count number of callable sites in the genome, excluding repetitive regions and exons 10k extended
wc -l gvcf-dadi-combined/dadi.allsites.nogeno.autosomes.rm_repeats.rm_exons_10k_extended.bed

``` 

##### Step 3 Prepare SFS
`sbatch 10_call-dadi-fs.sh` run dadi to GenerateFs in dadi format

##### Step 4 Run dadi-cli two population models 
```shell
sbatch 11_call-dadi-IM.sh
sbatch 12_call-dadi-no_mig.sh
sbatch 13_call-dadi-no-mig-size.sh
sbatch 14_call-dadi-sym-mig.sh
```
run dadi-cli to test 4 different two population models

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