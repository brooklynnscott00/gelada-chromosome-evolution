# dadi_cli 

## generate frequency spectra
`sbatch --mem=48G population_history/dadi_cli/generate-dadi-fs.sh`	jobID: 28173877	**DONE**

## plot frequency spectra
`sbatch --array=1-2 population_history/dadi_cli/plot-fs.sh`	jobID: 28414437	**DONE**

## make another frequency spectra for both where they aren't low pass
## compare frequncy spectra

## demographic inference
### northern/central analyses

isolation with migration 
`sbatch population_history/dadi_cli/nor-cen.dadi-IM.sh`	jobID: 28181915	**DONE**

no migration
`sbatch population_history/dadi_cli/nor-cen.dadi-no_mig.sh`	jobID: 28181918	**DONE**

no migration with size change 
`sbatch population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 28182490	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 28189709	**cancelled**
`sbatch population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 28470377

symmetrical migration
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`	jobID: 28182762	**warning**
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`	jobID: 28189715	**warning**
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`	jobID: 28470670

### central/southern analyses

isolation with migration
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28181914	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182086	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182312	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182387 **failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182480	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28189742	**cancelled**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28468831

no migration 
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28181917	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28182313	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28189778	**cancelled**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28468846

no migration with size change 
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28182495	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28182774	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28189793	**cancelled**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	JOBID: 28468927

symmetrical migration
`sbatch population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28182764	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28189795	**cancelled**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28468964

founder_asym
`sbatch population_history/dadi_cli/cen-sou.dadi-founder_asym.sh`	jobID: 28470360	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-founder_asym.sh`	jobID: 28470706

founder_nomig
founder_nomig_admix_early


## statistical testing 

## simulation 


## helpful links 
Data is not masked:

https://groups.google.com/g/dadi-user/c/esRqfOQ7Amc

# smcpp

