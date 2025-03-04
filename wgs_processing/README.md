# Scripts to run angsd analysis

### Analysis pipeline
These analyses begin with bam files that have already been mapped to the gelada reference genome. For mapping scripts refer to [Chiou et al. 2022](https://www.nature.com/articles/s41559-022-01703-4)

##### Step 1
`sbatch -p $WILDFIRE -q wildfire --time=7-00:00:00 --array=1-116 scripts/01_gatk-call.sh` run gatk in parallel to call varaints for each sample 

