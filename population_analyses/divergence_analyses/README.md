# Scripts to run divergence time estimates

### Dadi analysis pipeline

##### Step 1 Prepare input VCF


subset vcf to include dadi animals

'''sbatch scripts/bedtools-subtract-repeats.sh'''     jobID: 12179560     **DONE**

'''sbatch scripts/bedtools-subtract-exons_10k_extended.sh'''      jobID: 12179791     **DONE**

MAKE SURE TO ALSO FILTER FOR ONLY AUTOSOMES


##### Step 2 Get # of callable sites




Callable sites call-all-sites.sh

'''sbatch scripts/call-all-sites.sh'''        jobID: 11837302     **DONE**
path: /scratch/brscott4/gelada/data/gvcf-dadi-combined/final.allsites.nogeno.vcf.gz


## counting the number of callable sites in the neutral regions of the genome

'''sbatch scripts/bedtools-merge-allsites.sh'''     jobID: 12599409     **DONE**
merge the bed file in to regions 

'''sbatch scripts/bedtools-make-neutral-regions-bed.sh''' jobID: 12628445   **DONE**
remove the low quality/repeats/exons 10k extended

'''awk '{sum+=$3;sum1+=$2;} END{print sum-sum1;}' final.allsites.nogeno.filtered.pass.biallelic.rm_repeats.rm_exons_10k_extended.bed'''
number of callable sites in the neutral genome = 610270154

number of callable sites in the neutral genome = 610270154

NEUTRAL REGIONS:
### filter vcf for repeats
sbatch scripts/bedtools-subtract-repeats.sh   jobID: 11062541     **DONE** 
### filter vcf callable region variants for repeats
sbatch scripts/bedtools-subtract-repeats.sh     jobID: 12170803

### filter vcf for exons 10k extended
sbatch scripts/bedtools-subtract-exons_10k_extended.sh   jobID: 11063373    **DONE**
### filter vcf callable region variants for exons 10k extended
sbatch scripts/bedtools-subtract-exons_10k_extended.sh       jobID: 12171926

### path to vcf input:
/scratch/brscott4/gelada/data/vcf/NOR.CEN.22.rm_missing.biallelic.rm_repeats.rm_exons_10k_extended.vcf




##### Step 3 Prepare SFS
`sbatch population_analyses/divergence_analyses/03_run-dadi-fs.sh` run dadi to GenerateFs in dadi format

*********(need to edit the path to the vcf after filtering steps)
*********(possible also edit paths to the final sfs output)

##### Step 4 Run dadi-cli two population models 
```shell
sbatch population_analyses/divergence_analyses/04_dadi-IM.sh
sbatch population_analyses/divergence_analyses/04_dadi-no_mig.sh
sbatch population_analyses/divergence_analyses/04_dadi-sym_mig.sh
sbatch population_analyses/divergence_analyses/04_dadi-no_mig_size.sh
```
run dadi-cli to test 4 different two population models

********(go in and edit file paths to reflect sfs)


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