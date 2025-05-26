
# Calculate saf
`sbatch Fst/saf-north.sh`	jobID: 26336299	**timeout**
`sbatch --partition=general --time=2-00:00:00 Fst/saf-north.sh`	jobID: 26390398	**OOM**
`sbatch --partition=general --mem=64G --time=2-00:00:00 Fst/saf-north.sh`	jobID: 26425151	**timeout**
`sbatch --partition=general --mem=64G --time=7-00:00:00 Fst/saf-north.sh`	jobID: 26751456	**OOM**
`sbatch --partition=general --mem=364G --time=7-00:00:00 Fst/saf-north.sh`	jobID: 27561354

`sbatch Fst/saf-central.sh`	jobID: 26336318	**timeout**
`sbatch --partition=general --time=2-00:00:00 Fst/saf-central.sh`	jobID: 26390400	**OOM**
`sbatch --partition=general --mem=64G --time=2-00:00:00 Fst/saf-central.sh`	jobID: 26440176	**DONE**

`sbatch Fst/saf-southern.sh`	jobID: 26336362	**timeout**
`sbatch --partition=general --time=2-00:00:00 Fst/saf-southern.sh`	jobID: 26390418	**OOM**
`sbatch --partition=general --mem=64G --time=2-00:00:00 Fst/saf-southern.sh`	jobID: 26440191	**DONE**



`sbatch --depend=afterok:26390400,26390418 Fst/cen-sou.SFS.sh`	jobID: 
`sbatch --depend=afterok:26390398,26390400 Fst/nor-cen.SFS.sh`	jobID:
`sbatch --depend=afterok:26390398,26390418 Fst/nor-sou.SFS.sh`	jobID:

`sbatch Fst/realSFS-Fst.sh`

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
