# Calculate saf

`sbatch --array=1 --partition=general --mem=100G --time=7-00:00:00 Fst/angsd-saf.sh`	jobID: 28165747	**DONE**
`sbatch --array=2-22 --partition=general --mem=364G --time=7-00:00:00 Fst/angsd-saf.sh`	jobID: 28181806	**DONE**

`sbatch --array=1 --partition=general --mem=100G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28503408
`sbatch --dependency=afternotok:28503408_1 --array=1 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529047

`sbatch --array=2-22 --partition=general --mem=100G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28503847	**cancelled**

`sbatch --array=2-5 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529024
`sbatch --array=6 --partition=general --mem=200G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529034
`sbatch --array=8-10,12-16,18,22 --partition=general --mem=100G --time=7-00:00:00 Fst/joint-sfs-generation.sh`	jobID: 28529046



# get the global estimate
	-> Assuming idxname:here.fst.idx
	-> Assuming .fst.gz file: here.fst.gz
	-> FST.Unweight[nObs:1666245]:0.022063 Fst.Weight:0.034513
0.022063 0.034513
	-> FST.Unweight[nObs:1666245]:0.026867 Fst.Weight:0.031989
0.026867 0.031989
	-> FST.Unweight[nObs:1666245]:0.025324 Fst.Weight:0.021118
0.025324 0.021118
	-> pbs.pop1	0.023145
	-> pbs.pop2	0.005088
	-> pbs.pop3	0.009367
# below is not tested that much, but seems to work
../misc/realSFS fst stats2 here.fst.idx -win 50000 -step 10000 >slidingwindow
