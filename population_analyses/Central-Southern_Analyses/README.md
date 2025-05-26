# Scripts to run divergence time estimates between the central and southern geladas

### Dadi analysis pipeline
##### Prepare input VCF

Prepare a list of sample ID's to include in the dadi-cli analysis:
`data/dadi.sample_list.CEN.SOU.txt`

##### Prepare input VCF

`sbatch --array=1-22 population_analyses/Central-Southern_Analyses/01_dadi-make-vcf.sh`	jobID: 25390299	**DONE**
Filter VCF file for the samples that are listed in the sample list

`sbatch population_analyses/Central-Southern_Analyses/02_dadi-filter-vcf-autosomes.sh`	jobID: 25390731	**DONE**
Filter VCF to remove include only autosomes

`sbatch population_analyses/Central-Southern_Analyses/03_dadi-filter-vcf-subtract_repeats.sh`	jobID: 25386682	**DONE**
Filter VCF to remove repetitive regions 

`sbatch population_analyses/Central-Southern_Analyses/04_dadi-filter-vcf-subtract_exons_10k_extended.sh`	jobID: 25387029	**DONE**
Filter VCF to include putatively neutrally evolving regions 

##### Generate fs

`sbatch population_analyses/Central-Southern_Analyses/10_call-dadi-fs.sh`	jobID: 25614264	**DONE**

##### Run divergence models 

`sbatch population_analyses/Central-Southern_Analyses/11_call-dadi-IM.sh`	jobID: 25753112	**failed**
`sbatch population_analyses/Central-Southern_Analyses/11_call-dadi-IM.sh`	jobID: 25754053

`sbatch population_analyses/Central-Southern_Analyses/12_call-dadi-no_mig.sh`	jobID: 25754091

`sbatch population_analyses/Central-Southern_Analyses/13_call-dadi-no_mig_size.sh`	jobID: 25754092

`sbatch population_analyses/Central-Southern_Analyses/14_call-dadi-sym-mig.sh`	jobID: 25754109

