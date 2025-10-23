# Population history analysis pipeline

## dadi-cli 

Generate and plot frequency spectra:
```shell
$sbatch --mem=48G population_history/dadi_cli/generate-dadi-2dsfs.sh
$sbatch --array=1-2 population_history/dadi_cli/plot-fs.sh
```

`sbatch --mem=48G population_history/dadi_cli/generate-dadi-2dsfs.sh`	jobID: 33172977	**DONE**
`sbatch --mem=48G population_history/dadi_cli/generate-dadi-2dsfs.sh`	jobID: 33173783	**DONE**
`sbatch --array=1 population_history/dadi_cli/plot-fs.sh`	jobID: 33173871

`sbatch --array=1-6 --mem=32G population_history/dadi_cli/cen_single/generate-fs.sh`	jobID: 33112792	**DONE**
`sbatch --array=1-7 --mem=32G population_history/dadi_cli/nor_single/generate-fs.sh`	jobID: 33112794	**DONE**
`sbatch --mem=48G population_history/dadi_cli/generate-dadi-2dsfs.sh`	jobID: 33112969	**DONE**

### northern-central analyses

```shell
$module load mamba/latest
$source activate dadi
$python population_history/dadi_cli/check_projection.py
dadi.northern.autosomes.12.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1183793.7020448036
dadi.northern.autosomes.14.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1225010.890615912
dadi.northern.autosomes.22.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1295766.0
dadi.northern.autosomes.16.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1258103.8705176492
dadi.northern.autosomes.10.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1131180.8463259274
dadi.northern.autosomes.20.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1304820.5238095196
dadi.northern.autosomes.18.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1284699.955980855

dadi.central.autosomes.22.noncoding.lowpass.folded.fs: S = 996744.0
dadi.central.autosomes.20.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1023125.9696969663
dadi.central.autosomes.16.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 979527.6576190921
dadi.central.autosomes.12.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 910670.5464473574
dadi.central.autosomes.14.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 948101.2375652818
dadi.central.autosomes.10.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 864905.8368566395
dadi.central.autosomes.18.noncoding.rm_common_high_het_sites_0.8.lowpass.folded.fs: S = 1005972.9942583684
```

```shell
$sbatch population_history/dadi_cli/nor-cen/nor-cen.dadi-IM.sh
$sbatch population_history/dadi_cli/nor-cen/nor-cen.dadi-no_mig.sh
$sbatch population_history/dadi_cli/nor-cen/nor-cen.dadi-sym_mig.sh
$sbatch population_history/dadi_cli/nor-cen/nor-cen.dadi-asym_mig.sh
$sbatch --partition=general --time=24:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-anc_asym_mig_size.sh

```

no migration with size change 
`sbatch --partition=general --time=1-00:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-no_mig_size.sh`	jobID: 33114770	**timeout**
`sbatch --partition=general --time=1-00:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-no_mig_size.sh`	jobID: 33166385

`sbatch --partition=general --time=24:00:00 --mem=32G population_history/dadi_cli/nor-cen/nor-cen.dadi-IM_pre.sh`	jobID: 33114778	**failed**
`sbatch --partition=general --time=24:00:00 --mem=32G population_history/dadi_cli/nor-cen/nor-cen.dadi-IM_pre.sh`	jobID: 33166424

`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-anc_asym_mig.sh`	jobID: 33114781	**error**
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-anc_asym_mig.sh`	jobID: 33166426

`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-asym_mig_size.sh`	jobID: 33173274	**warning**
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/nor-cen/nor-cen.dadi-asym_mig_size.sh`	jobID: 33173834	**warning**

# simulation 
`sbatch population_history/dadi_cli/dadi-simulate-IM.sh`	jobID: 31888526
`sbatch population_history/dadi_cli/plot-fs.sh`	jobID: 31888939

### central-southern analyses

```shell

```

`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-no_mig_size.sh`	jobID: 33174003	**warning**
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-no_mig_size.sh`	jobID: 33174563	**warning**

`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-sym_mig.sh`	jobID: 33173988	**warning**
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-sym_mig.sh`	jobID: 33174564	**warnings**

`sbatch --partition=general --time=24:00:00 --mem=64G population_history/dadi_cli/cen-sou/cen-sou.dadi-IM.sh`	jobID: 33173987	**warning**
`sbatch --partition=general --time=24:00:00 --mem=64G population_history/dadi_cli/cen-sou/cen-sou.dadi-IM.sh`	jobID: 33174565

`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-no_mig.sh`	jobID: 33174013	**warning**
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-no_mig.sh`	jobID: 33175625	**warning**

`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-founder_asym.sh`	jobID: 33174026	**warning**
`sbatch --partition=general --time=24:00:00 population_history/dadi_cli/cen-sou/cen-sou.dadi-founder_asym.sh`	jobID: 33175621	**warnings**

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
$sbatch --array=68-88 population_history/smc/vcf2smc-nor-cen.NOR.sh
$sbatch --array=68-88 population_history/smc/vcf2smc-nor-cen.CEN.sh
$sbatch population_history/smc/nor-cen.estimation.NOR.sh
$sbatch population_history/smc/nor-cen.estimation.CEN.sh
$sbatch --array=68-88 population_history/smc/nor-cen.joint-fs.12.sh # jobID: 28563838
$sbatch --array=68-88 population_history/smc/nor-cen.joint-fs.21.sh # jobID: 28564166
$sbatch population_history/smc/nor-cen.split-time.sh # jobID: 28565234
$sbatch population_history/smc/nor-cen.plot.sh # 28626551
```

`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33208821	**failed**
`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33208914	**failed**
`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33208951	**failed**
`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33209040	**failed**
`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33209408	**OOM**
`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33209661 **failed**

Running the posterior on the split estimate output from SMC++
`sbatch population_history/smc/nor-cen.posterior.sh`	jobID: 33463457	**DONE**

Try adjusting the estimate step to include the -c flag 
this may help with the long runs of homozygostiy errors
-c 50000

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

### bootstrapping 

```shell
$sbatch population_history/smc_bootstrap/make-smc-mask.sh	# jobID: 33949177
```

jobID: 34454541

```shell
$sbatch --mem=32G --cpus-per-task=16 --array=1-100 population_history/smc_bootstrap/vcf2smc.nor.20.sh # 34077267
$sbatch --mem=32G --cpus-per-task=16 --array=2-100 population_history/smc_bootstrap/vcf2smc.cen.20.sh # 34078502
$sbatch --mem=32G --cpus-per-task=16 --array=1-100 population_history/smc_bootstrap/vcf2smc.sou.20.sh # 34077279
```

`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.nor.20.sh`	jobID: 34377269	**DONE**
`sbatch --mem=32G --cpus-per-task=16 --array=2-100 population_history/smc_bootstrap/vcf2smc.nor.20.sh`	jobID: 34377466	**DONE**
`sbatch --mem=32G --cpus-per-task=16 --array=2 population_history/smc_bootstrap/vcf2smc.nor.20.sh`	jobID: 34432383	**DONE**

`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.cen.20.sh`	jobID: 34439843	**failed**
`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.cen.20.sh`	jobID: 34550731	**failed**
`sbatch --mem=32G --cpus-per-task=16 --array=2 population_history/smc_bootstrap/vcf2smc.cen.20.sh`	jobID: 34444493	**failed**

`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.cen.20.sh`	jobID: 34650395	**failed**
`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.cen.20.sh`	jobID: 34650416	**failed**
`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.cen.20.sh`	jobID: 34650540

`sbatch --mem=32G --cpus-per-task=16 --array=1 population_history/smc_bootstrap/vcf2smc.sou.20.sh`	jobID: 34439905	**DONE**
`sbatch --mem=32G --cpus-per-task=16 --array=2-100 population_history/smc_bootstrap/vcf2smc.sou.20.sh`	jobID: 34650612

`sbatch --mem=32G --array=1 population_history/smc_bootstrap/estimation.nor.20.sh`	jobID: 34078480

`sbatch --mem=32G --array=1 population_history/smc_bootstrap/estimation.cen.20.sh`
