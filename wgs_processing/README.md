# Scripts to run angsd analysis

### Analysis pipeline
These analyses begin with bam files that have already been mapped to the gelada reference genome. For mapping scripts refer to [Chiou et al. 2022](https://www.nature.com/articles/s41559-022-01703-4)

##### Step 1
`sbatch -p $WILDFIRE -q wildfire --time=7-00:00:00 --array=1-116 scripts/01_gatk-call.sh` run gatk in parallel to call variants for each sample 

##### Step 2
`sbatch -p htc -q normal --time=4:00:00 --array=1-947 02_gatk-genotype.sh` run gatk genotype in parallel

`sbatch -p htc -q normal --time=4:00:00 --array=1-947 02_gatk-genotype.sh` run it again 

##### Step 3
`sbatch -p $WILDFIRE -q wildfire --exclusive 03_gatk-filter.sh`  filter variants

##### Step 4
`sbatch -p $WILDFIRE -q wildfire --array=1-22 04_bcftools-concat.sh` 

