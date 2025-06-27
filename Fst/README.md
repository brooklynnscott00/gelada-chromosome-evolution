# Calculate saf

```shell
sbatch --array=1 --partition=general --mem=100G --time=7-00:00:00 Fst/angsd-saf.sh`	# jobID: 28165747
sbatch --array=2-22 --partition=general --mem=364G --time=7-00:00:00 Fst/angsd-saf.sh`	# jobID: 28181806
```


`sbatch --array=1 --partition=general --mem=100G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28503408	**OOM**
`sbatch --dependency=afternotok:28503408_1 --array=1 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529047

`sbatch --array=2-22 --partition=general --mem=100G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28503847	**cancelled**

`sbatch --array=2-5 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529024	**DONE**
`sbatch --array=6 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529034	**DONE**
`sbatch --array=8-10,12-16,18,22 --partition=general --mem=100G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529046	**DONE**


