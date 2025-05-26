# Scripts to run divergence time estimates between the northern and central geladas

### Dadi analysis pipeline
##### Prepare input VCF

Prepare a list of sample ID's to include in the dadi-cli analysis:
`data/dadi.sample_list.NOR.CEN.txt`

`sbatch --array=1-22 population_analyses/Northern-Central_Analyses/01_dadi-make-vcf.sh`	jobID:  25390279	**DONE**
Filter VCF file for the samples that are listed in the sample list

`sbatch population_analyses/Northern-Central_Analyses/02_dadi-filter-vcf-autosomes.sh`	jobID: 25365157	**DONE**
jobID: 25390505	**DONE**
Filter VCF to remove include only autosomes

`sbatch population_analyses/Northern-Central_Analyses/03_dadi-filter-vcf-subtract_repeats.sh`	jobID: 25386659	**DONE**
Filter VCF to remove repetitive regions 

`sbatch population_analyses/Northern-Central_Analyses/04_dadi-filter-vcf-subtract_exons_10k_extended.sh`	jobID: 25386929	**DONE**
Filter VCF to include putatively neutrally evolving regions 

##### Generate fs

`sbatch population_analyses/Northern-Central_Analyses/10_call-dadi-fs.sh`	jobID: 25541982	**DONE**
Generate a fs using dadi

##### Run divergence models 
`sbatch population_analyses/Northern-Central_Analyses/11_call-dadi-IM.sh`	jobID: 25632649	**DONE**

`sbatch population_analyses/Northern-Central_Analyses/12_call-dadi-no_mig.sh`	jobID: 25632663	**DONE**

`sbatch population_analyses/Northern-Central_Analyses/13_call-dadi-no_mig_size.sh`	jobID: 25632665	**TIMEOUT**
`sbatch --partition=general --time=12:00:00 population_analyses/Northern-Central_Analyses/13_call-dadi-no_mig_size.sh`	jobID: 25702771

`sbatch population_analyses/Northern-Central_Analyses/14_call-dadi-sym-mig.sh`	jobID: 25632668	**close to boundaries**

##### statistical testing 

`sbatch population_analyses/Northern-Central_Analyses/call-dadi-bootstrap-fs.sh`	jobID: 25703731	**DONE**
Generate a fs with dadi using bootstrap 100

`sbatch population_analyses/Northern-Central_Analyses/dadi-StatDM.sh`	jobID: 25753270	**failed**
`sbatch population_analyses/Northern-Central_Analyses/dadi-StatDM.sh`	jobID: 25754230
