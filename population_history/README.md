# dadi_cli 

## generate frequency spectra
`sbatch population_history/dadi_cli/generate-dadi-fs.sh`	jobID: 28170262	**failed**
`sbatch --mem=48G population_history/dadi_cli/generate-dadi-fs.sh`	jobID: 28173877	**DONE**

## plot frequency spectra
## compare frequncy spectra

## demographic inference
### northern/central analyses

isolation with migration 
`sbatch population_history/dadi_cli/nor-cen.dadi-IM.sh`	jobID: 28181915	**DONE**

no migration
`sbatch population_history/dadi_cli/nor-cen.dadi-no_mig.sh`	jobID: 28181918	**DONE**

no migration with size change 
`sbatch population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 28182490	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 28189709

symmetrical migration
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`	jobID: 28182762	**warning**
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`	jobID: 28189715	**warning**

### central/southern analyses

isolation with migration
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28181914	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182086	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182312	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182387 **failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182480	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28189742

no migration 
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28181917	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28182313	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28189778

no migration with size change 
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28182495	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28182774	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28189793

symmetrical migration
`sbatch population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28182764	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28189795

## statistical testing 

## simulation 


## helpful links 
Data is not masked:

https://groups.google.com/g/dadi-user/c/esRqfOQ7Amc

