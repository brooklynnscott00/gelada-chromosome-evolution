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
`sbatch population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 28470377 **timeout**
`sbatch --time=4:00:00 population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh` jobID: 28476024 **timeout**
`sbatch --partition=general --time=1-00:00:00 population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`  jobID: 28476030 **timeout**
`sbatch --partition=general --time=1-00:00:00 population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`  jobID: 28561149


symmetrical migration
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`	jobID: 28471227 **warning**
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`    jobID: 28476052 **warnings**
`sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh`    jobID: 28476276 **warnings**

### central/southern analyses

--maxtime

isolation with migration
`sbatch population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28182480	**timeout**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28468831
`sbatch --time=1:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 28472708 **timeout**
dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.0671 0.0867 10 0.1 0.006 0.0112 \
    --nomisid \
    --lbounds 1e-3 1e-3 1e-1 1e-3 1e-4 1e-3 \
    --ubounds 0.99 0.99 100 10 1e-1 0.99 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--force-convergence 50 \
	--optimizations 20 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 4
`sbatch --time=4:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`  jobID: 28476095
dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.0671 0.0867 10 0.1 0.006 0.0112 \
    --nomisid \
    --lbounds 1e-3 1e-3 1e-1 1e-3 1e-4 1e-3 \
    --ubounds 0.99 0.99 100 10 1e-1 0.99 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--force-convergence 50 \
	--optimizations 10 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 4
`sbatch --time=4:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`  jobID: 28476303
dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.0671 0.0867 10 0.1 0.006 0.0112 \
    --nomisid \
    --lbounds 1e-3 1e-3 1e-1 1e-3 1e-4 1e-3 \
    --ubounds 0.99 0.99 100 10 1e-1 0.99 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--force-convergence 50 \
	--optimizations 10 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--maxtime 1 \
	--cpus 4
`sbatch --time=4:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh`  jobID: 28476468
dadi-cli InferDM --fs dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs \
	--model IM \
	--p0 0.0671 0.0867 10 0.1 0.006 0.0112 \
    --nomisid \
    --lbounds 1e-5 1e-5 1e-5 1e-5 1e-5 1e-5 \
    --ubounds 10 10 100 10 10 10 \
	--output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.IM.demo.params \
	--force-convergence 50 \
	--optimizations 10 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--maxtime 1 \
	--cpus 4
`sbatch --time=4:00:00 population_history/dadi_cli/cen-sou.dadi-IM.sh` jobID: 28561170








no migration 
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28182313	**timeout**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28468846
dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 0.3692819110903314 4.902925495516077 0.5391757626755409 \
    --model no_mig \
    --nomisid \
    --lbounds 1e-3 1e-1 1e-3 \
    --ubounds 0.99 10 0.99 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.no_mig.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
    --grids 40 50 60 \
	--cpus 4
`sbatch --time=1:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 28472791 **timeout**
dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 0.369 4.903 0.539 \
    --model no_mig \
    --nomisid \
    --lbounds 1e-3 1e-1 1e-3 \
    --ubounds 10 10 10 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.no_mig.demo.params \
	--force-convergence 50 \
    --optimizations 20 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 4

no migration with size change 
`sbatch population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28182774	**timeout**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	JOBID: 28468927
dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 7.041749815893527e-05 5.74172413630268e-06 0.21186611274699285 3.936396844907854 7.486312764449154e-08 0.3296989171413364 \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-7 1e-8 1e-2 1e-1 1e-10 1e-2 \
    --ubounds 1e-4 1e-4 10 10 1e-6 110 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.no_mig_size.demo.params \
	--force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
    --grids 40 50 60 \
	--cpus 4
`sbatch --time=1:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh`	jobID: 28472837 **timeout**
dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 7.042e-05 5.742e-06 0.213 3.936 7.486e-08 0.330 \
    --model no_mig_size \
    --nomisid \
    --lbounds 1e-7 1e-8 1e-2 1e-1 1e-10 1e-2 \
    --ubounds 1e-4 1e-4 10 10 1e-6 110 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.no_mig_size.demo.params \
	--force-convergence 50 \
    --optimizations 20 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
	--cpus 4

symmetrical migration
`sbatch population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28182764	**timeout**
`sbatch --partition=general --time=7-00:00:00 population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28468964
dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 0.7505340443081098 18.009061899475363 0.14030037448281635 6.736930348692804 \
    --model sym_mig \
    --nomisid \
    --lbounds 1e-2 1e-1 1e-3 1e-2 \
    --ubounds 10 100 10 100 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.sym_mig.demo.params \
    --force-convergence 100 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
    --grids 40 50 60 \
    --cpus 4
`sbatch --time=1:00:00 population_history/dadi_cli/cen-sou.dadi-sym_mig.sh`	jobID: 28472876 **timeout**
dadi-cli InferDM --fs dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.folded.fs \
    --p0 0.751 18.009 0.1403 6.737 \
    --model sym_mig \
    --nomisid \
    --lbounds 1e-2 1e-1 1e-3 1e-2 \
    --ubounds 10 100 10 100 \
    --output-prefix dadi_results/cen-sou/${dataset}.cen-sou.autosomes.noncoding.lowpass.sym_mig.demo.params \
    --force-convergence 50 \
    --optimizations 20 \
	--coverage-model dadi_results/cen-sou/dadi.cen-sou.autosomes.noncoding.lowpass.folded.fs.coverage.pickle 22 22 \
    --cpus 4

founder_asym
`sbatch population_history/dadi_cli/cen-sou.dadi-founder_asym.sh`	jobID: 28470360	**failed**
`sbatch population_history/dadi_cli/cen-sou.dadi-founder_asym.sh`	jobID: 28470706	**timeout**
`sbatch --partition=general --time=12:00:00 population_history/dadi_cli/cen-sou.dadi-founder_asym.sh`	jobID: 28472129

founder_nomig
founder_nomig_admix_early


## statistical testing 

## simulation 


## helpful links 
Data is not masked:

https://groups.google.com/g/dadi-user/c/esRqfOQ7Amc

# smcpp

`sbatch population_history/smc/make-inaccessible-mask.sh`	jobID: 28472123 **DONE**

## northern central split

```shell
sbatch --array=68-88 population_history/smc/vcf2smc-nor-cen.NOR.sh
sbatch --array=68-88 population_history/smc/vcf2smc-nor-cen.CEN.sh
sbatch population_history/smc/nor-cen.estimation.NOR.sh
sbatch population_history/smc/nor-cen.estimation.CEN.sh
sbatch --array=68-88 population_history/smc/nor-cen.joint-fs.12.sh # jobID: 28563838
sbatch --array=68-88 population_history/smc/nor-cen.joint-fs.21.sh # jobID: 28564166
sbatch population_history/smc/nor-cen.split-time.sh # jobID: 28565234
```

`sbatch population_history/smc/nor-cen.plot.sh` jobID: 28567066



## central southern split

```shell
sbatch --array=68-88 population_history/smc/cen-sou.vcf2smc.CEN.sh #    jobID: 28563445 
sbatch --array=68-88 population_history/smc/cen-sou.vcf2smc.SOU.sh #    jobID: 28563446
```

`sbatch population_history/smc/cen-sou.estimation.CEN.sh`   jobID: 28564212 **DONE**
`sbatch --partition=general --time=24:00:00 --mem=128G --dependency=afternotok:28564212 population_history/smc/cen-sou.estimation.CEN.sh`   jobID: 28564252

`sbatch population_history/smc/cen-sou.estimation.SOU.sh`   jobID: 28564219 **OOM**
`sbatch --partition=general --time=24:00:00 --mem=128G --dependency=afternotok:28564219 population_history/smc/cen-sou.estimation.SOU.sh`   jobID: 28564255
