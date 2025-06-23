# Calculate saf

`sbatch --array=1 --partition=general --mem=100G --time=7-00:00:00 Fst/angsd-saf.sh`	jobID: 28165747	**DONE**
`sbatch --array=2-22 --partition=general --mem=364G --time=7-00:00:00 Fst/angsd-saf.sh`	jobID: 28181806	**DONE**


`sbatch --partition=highmem --mem=800G Fst/cen-sou.SFS.sh`	jobID: 28414144	**tiemout**
`sbatch --partition=highmem  --time=7-00:00:00 --mem=800G Fst/cen-sou.SFS.sh`	jobID: 

`sbatch --partition=highmem --mem=800G Fst/nor-cen.SFS.sh`	jobID: 28414145	**failed**

`sbatch --partition=highmem --mem=800G Fst/nor-sou.SFS.sh`	jobID: 28414147	**failed**


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
