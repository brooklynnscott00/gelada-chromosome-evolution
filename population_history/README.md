# Population history analysis pipeline

## dadi-cli 

Generate and plot frequency spectra:
```shell
$sbatch --mem=48G population_history/dadi_cli/generate-dadi-2dfs.sh
$sbatch --array=1-2 population_history/dadi_cli/plot-fs.sh
```

### northern-central analyses

```shell
$sbatch population_history/dadi_cli/nor-cen.dadi-IM.sh	# jobID: 28181915
$sbatch population_history/dadi_cli/nor-cen.dadi-no_mig.sh	# jobID: 28181918
$sbatch population_history/dadi_cli/nor-cen.dadi-sym_mig.sh	# jobID: 32047126
$sbatch population_history/dadi_cli/nor-cen.dadi-asym_mig.sh	# jobID: 32047191
```

no migration with size change 
`sbatch --partition=general --time=1-00:00:00 population_history/dadi_cli/nor-cen.dadi-no_mig_size.sh`	jobID: 32543519

IM pre
`sbatch --partition=general --time=24:00:00 --mem=32G population_history/dadi_cli/nor-cen.dadi-IM_pre.sh`	jobID: 32543607

ancient asymmetrical migration
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/nor-cen.dadi-anc_asym_mig.sh`	jobID: 32544596

`sbatch population_history/dadi_cli/nor-cen.dadi-anc_asym_mig_size.sh`	jobID: 32047145	**timeout**

`sbatch population_history/dadi_cli/nor-cen.dadi-asym_mig_size.sh`	jobID: 32047150	**timeout**

# simulation 
`sbatch population_history/dadi_cli/dadi-simulate-IM.sh`	jobID: 31888526
`sbatch population_history/dadi_cli/plot-fs.sh`	jobID: 31888939

### central-southern analyses

```shell
$sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig_size.sh # jobID: 32420743
$sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou.dadi-sym_mig.sh # jobID: 32420989
```

isolation with migration
`sbatch --partition=general --time=24:00:00 --mem=64G population_history/dadi_cli/cen-sou.dadi-IM.sh`	jobID: 32544907

no migration 
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou.dadi-no_mig.sh`	jobID: 32544936


founder_asym
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou.dadi-founder_asym.sh`	jobID: 32544937

founder_nomig

founder_nomig_admix_early

### southern analysis single population 

Generate a 1D sfs for the southern population. Set the number of haplotypes ranging from 2-22
```shell
$sbatch --mem=32G population_history/dadi_cli/sou_single/generate-fs.sh
$sbatch --mem=32G population_history/dadi_cli/sou_single/plot-fs.sh
```

Check the projection of each frequency spectra
```shell
$python population_history/dadi_cli/sou_single/check_projection.py

dadi_results/southern/dadi.southern.18.autosomes.noncoding.lowpass.folded.fs: S = 259061.44258373184
dadi_results/southern/dadi.southern.16.autosomes.noncoding.lowpass.folded.fs: S = 546894.9788115575
dadi_results/southern/dadi.southern.6.autosomes.noncoding.lowpass.folded.fs: S = 3316896.41645416
dadi_results/southern/dadi.southern.22.autosomes.noncoding.lowpass.folded.fs: S = 17356.0
dadi_results/southern/dadi.southern.12.autosomes.noncoding.lowpass.folded.fs: S = 1539096.5292184567
dadi_results/southern/dadi.southern.8.autosomes.noncoding.lowpass.folded.fs: S = 3054079.216228148
dadi_results/southern/dadi.southern.2.autosomes.noncoding.lowpass.folded.fs: S = 1378599.445609292
dadi_results/southern/dadi.southern.10.autosomes.noncoding.lowpass.folded.fs: S = 2280856.0431641378
dadi_results/southern/dadi.southern.4.autosomes.noncoding.lowpass.folded.fs: S = 2571184.7473014756
dadi_results/southern/dadi.southern.14.autosomes.noncoding.lowpass.folded.fs: S = 965335.3334850064
dadi_results/southern/dadi.southern.20.autosomes.noncoding.lowpass.folded.fs: S = 90539.59740259734
```

```shell
$sbatch --mem=32G --partition=general --time=24:00:00 population_history/dadi_cli/sou_single/southern.dadi-three_epoch_inbreeding.sh
$sbatch --mem=32G --partition=general --time=24:00:00 population_history/dadi_cli/sou_single/southern.dadi-two_epoch.sh
```

`sbatch --mem=32G --partition=htc --time=4:00:00 population_history/dadi_cli/sou_single/southern.dadi-bottlegrowth_1d.sh`	jobID: 32094028	**timeout**
`sbatch --mem=32G --partition=general --time=24:00:00 population_history/dadi_cli/sou_single/southern.dadi-bottlegrowth_1d.sh`	jobID: 32297977

`sbatch --mem=32G --partition=htc --time=4:00:00 population_history/dadi_cli/sou_single/southern.dadi-growth.sh`	jobID: 32094033	**timeout**
`sbatch --mem=32G --partition=general --time=24:00:00 population_history/dadi_cli/sou_single/southern.dadi-growth.sh`	jobID: 32297980

`sbatch --mem=32G population_history/dadi_cli/sou_single/southern.dadi-snm_1d.sh`	jobID: 31980439	**DONE**

`sbatch --mem=32G --partition=htc --time=4:00:00 population_history/dadi_cli/sou_single/southern.dadi-three_epoch.sh`	jobID: 32094039	**timeout**
`sbatch --mem=32G --partition=general --time=24:00:00 population_history/dadi_cli/sou_single/southern.dadi-three_epoch.sh`	jobID: 32298080




#### central analysis single population
`sbatch --mem=32G population_history/dadi_cli/cen_single/generate-fs.sh`  jobID: 28877591	**failed**
`sbatch --mem=32G population_history/dadi_cli/cen_single/generate-fs.sh`	jobID: 28877602	**DONE**

`sbatch --mem=32G population_history/dadi_cli/cen_single/plot-fs.sh`	jobID: 28877680	**done**

`sbatch --mem=32G population_history/dadi_cli/cen_single/central.bottlegrowth_1d.sh`	jobID: 28877683	**timeout**
`sbatch --mem=32G --time=4:00:00 population_history/dadi_cli/cen_single/central.bottlegrowth_1d.sh`	jobID: 28878186	**timeout

`sbatch --mem=32G population_history/dadi_cli/cen_single/central.growth.sh`	jobID: 28877685	**timeout**
`sbatch --mem=32G --time=4:00:00 population_history/dadi_cli/cen_single/central.growth.sh`	jobID: 28878192	**timeout**

`sbatch --mem=32G population_history/dadi_cli/cen_single/central.snm_1d.sh`	jobID: 28877686	**DONE**

`sbatch --mem=32G population_history/dadi_cli/cen_single/central.three_epoch.sh`	jobID: 28877689	**timeout**
`sbatch --mem=32G --time=4:00:00 population_history/dadi_cli/cen_single/central.three_epoch.sh`	jobID: 28878176	**timeout**

`sbatch --mem=32G population_history/dadi_cli/cen_single/central.three_epoch_inbreeding.sh`	jobID: 28877714	**timeout**
`sbatch --mem=32G --time=4:00:00 population_history/dadi_cli/cen_single/central.three_epoch_inbreeding.sh`	jobID: 28878173	**timeout**

`sbatch --mem=32G population_history/dadi_cli/cen_single/central.two_epoch.sh`	jobID: 28877715	**Timeout**
`sbatch --mem=32G --time=4:00:00 population_history/dadi_cli/cen_single/central.two_epoch.sh`	jobID: 28878164	**timoeut**



## smcpp

```shell
$sbatch population_history/smc/make-inaccessible-mask.sh`
```

### northern-central split

```shell
sbatch --array=68-88 population_history/smc/vcf2smc-nor-cen.NOR.sh
sbatch --array=68-88 population_history/smc/vcf2smc-nor-cen.CEN.sh
sbatch population_history/smc/nor-cen.estimation.NOR.sh
sbatch population_history/smc/nor-cen.estimation.CEN.sh
sbatch --array=68-88 population_history/smc/nor-cen.joint-fs.12.sh # jobID: 28563838
sbatch --array=68-88 population_history/smc/nor-cen.joint-fs.21.sh # jobID: 28564166
sbatch population_history/smc/nor-cen.split-time.sh # jobID: 28565234
sbatch population_history/smc/nor-cen.plot.sh # 28626551
```

### central-southern split

```shell
sbatch --array=68-88 population_history/smc/cen-sou.vcf2smc.CEN.sh #    jobID: 28563445 
sbatch --array=68-88 population_history/smc/cen-sou.vcf2smc.SOU.sh #    jobID: 28563446
sbatch population_history/smc/cen-sou.estimation.CEN.sh #   28564212
sbatch --partition=general --time=24:00:00 --mem=128G population_history/smc/cen-sou.estimation.SOU.sh #    28564255
sbatch --array=68-88 population_history/smc/cen-sou.joint-fs.12.sh # 28627210, 28632993
sbatch --array=68-88 population_history/smc/cen-sou.joint-fs.21.sh # 28627221, 28633025
sbatch --mem=400G population_history/smc/cen-sou.split-time.sh
sbatch population_history/smc/cen-sou.plot.sh
```
