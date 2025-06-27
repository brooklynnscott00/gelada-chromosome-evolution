# Fst 

```shell
sbatch --array=1 --partition=general --mem=100G --time=7-00:00:00 Fst/angsd-saf.sh`	# jobID: 28165747
sbatch --array=2-22 --partition=general --mem=364G --time=7-00:00:00 Fst/angsd-saf.sh`	# jobID: 28181806
sbatch --array=1-5 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh
sbatch --array=6-22 Fst/joint-sfs-generation.sh
```

`sbatch --array=1 Fst/prepare-fst.sh`	jobID: 28626375	**failed**
`sbatch --array=1 Fst/prepare-fst.sh`	jobID: 28626489
