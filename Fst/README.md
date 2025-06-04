
# Calculate saf

`sbatch --partition=general --mem=364G --time=7-00:00:00 Fst/saf-north.sh`	jobID: s

`sbatch --partition=general --mem=64G --time=7-00:00:00 Fst/saf-central.sh`	jobID: 27631613	**DONE**

`sbatch --partition=general --mem=64G --time=7-00:00:00 Fst/saf-southern.sh`	jobID: 27631620	**DONE**


`sbatch Fst/cen-sou.SFS.sh`	jobID: 27817241	**failed**
`sbatch Fst/cen-sou.SFS.sh`	jobID: 27817321	**OOM**
`sbatch Fst/cen-sou.SFS.sh`	jobID: 27817333	**OOM**
`sbatch --mem=400G Fst/cen-sou.SFS.sh`	jobID: 27817660

`sbatch Fst/nor-cen.SFS.sh`	jobID: 

`sbatch Fst/nor-sou.SFS.sh`	jobID: 



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
