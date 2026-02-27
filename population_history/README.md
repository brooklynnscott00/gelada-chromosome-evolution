# Population history analysis pipeline

## dadi-cli 

```shell
$sbatch population_history/dadi_cli/generate-dadi-2dsfs.sh
$sbatch population_history/dadi_cli/plot-fs.sh
```

sbatch population_history/dadi_cli/plot-fs.sh	jobID: 47807023

```shell
$sbatch population_history/nor-cen.dadi-IM.sh
$sbatch population_history/nor-cen.dadi-no_mig.sh
$sbatch population_history/nor-cen.dadi-sym_mig.sh
$sbatch population_history/nor-cen.dadi-asym_mig.sh
$sbatch --partition=general --time=24:00:00 population_history/nor-cen.dadi-anc_asym_mig_size.sh
```

```shell
sbatch population_history/dadi_cli/dadi-simulate-IM.sh
```
jobID: 46168372	**failed**
jobID: 46323211
simulate isolation with migration


## SMC++

### northern-central

```shell
$sbatch --array=68-88 population_history/smc/nor_cen/vcf2smc-nor-cen.NOR.sh
$sbatch --array=68-88 population_history/smc/nor_cen/vcf2smc-nor-cen.CEN.sh
$sbatch population_history/smc/nor_cen/nor-cen.estimation.NOR.sh
$sbatch population_history/nor_cen/smc/nor-cen.estimation.CEN.sh
$sbatch --array=68-88 population_history/smc/nor_cen/nor-cen.joint-fs.12.sh # jobID: 28563838
$sbatch --array=68-88 population_history/smc/nor_cen/nor-cen.joint-fs.21.sh # jobID: 28564166
$sbatch population_history/smc/nor_cen/nor-cen.split-time.sh # jobID: 28565234
$sbatch population_history/smc/nor_cen/nor-cen.plot.sh # 28626551
```

### central-southern
```shell
$sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.vcf2smc.CEN.sh #    jobID: 28563445 
$sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.vcf2smc.SOU.sh #    jobID: 28563446
$sbatch population_history/smc/cen_sou/cen-sou.estimation.CEN.sh #   28564212
$sbatch --partition=general --time=24:00:00 --mem=128G population_history/smc/cen_sou/cen-sou.estimation.SOU.sh #    28564255
$sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.joint-fs.12.sh # 28627210, 28632993
$sbatch --array=68-88 population_history/smc/cen_sou/en-sou.joint-fs.21.sh # 28627221, 28633025
$sbatch --mem=400G population_history/smc/cen_sou/cen-sou.split-time.sh
$sbatch population_history/smc/cen_sou/cen-sou.plot.sh
```

sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.vcf2smc.CEN.sh		jobID: 47818655	**DONE**
sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.vcf2smc.SOU.sh		jobID: 47818575	**DONE**

sbatch population_history/smc/cen_sou/cen-sou.estimation.CEN.sh		jobID: 47820710	**DONE**

sbatch population_history/smc/cen_sou/cen-sou.estimation.SOU.sh		jobID: 47821907	**OOM**
sbatch --partition=general --time=24:00:00 --mem=128G  population_history/smc/cen_sou/cen-sou.estimation.SOU.sh		jobID: 47874039	**DONE**

sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.joint-fs.12.sh	jobID: 47890699	**DONE**
sbatch --array=68-88 population_history/smc/cen_sou/cen-sou.joint-fs.21.sh	jobID: 47890724	**DONE**

sbatch --mem=400G population_history/smc/cen_sou/cen-sou.split-time.sh		jobID: 47896042	**DONE**

sbatch population_history/smc/cen_sou/cen-sou.plot.sh	jobID: 47923766

### northern-southern 
```shell
$sbatch population_history/smc/nor_sou/nor-sou.estimation.NOR.sh	# jobID: 41041893
$sbatch --mem=128G population_history/smc/nor_sou/nor-sou.estimation.SOU.sh	# jobID: 41043104
$sbatch population_history/smc/nor_sou/nor-sou.joint-fs.12.sh	# jobID: 41054285
$sbatch population_history/smc/nor_sou/nor-sou.joint-fs.21.sh	# jobID: 41054420
$sbatch --mem=400G population_history/smc/nor_sou/nor-sou.split-time.sh # jobID: 41600838
$sbatch population_history/smc/nor_sou/nor-sou.plot.sh # jobID: 41909798
```
sbatch population_history/smc/nor_sou/nor-sou.joint-fs.12.sh		jobID: 47924099
sbatch population_history/smc/nor_sou/nor-sou.joint-fs.21.sh		jobID: 47924125

