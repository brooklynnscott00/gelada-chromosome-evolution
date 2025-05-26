#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="gatk-vfl"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --time=4:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --export=NONE

slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)

source scripts/_include_options.sh


module load perl-5.26.2-gcc-12.1.0
module load parallel-20220522-gcc-12.1.0
module load jdk-12.0.2_10-gcc-12.1.0
module load htslib-1.21-gcc-11.2.0
module load shpc/python/3.9.2-slim/module
module load bcftools-1.14-gcc-11.2.0

parallel -j $slots scripts/gatk-filter-variants-single.sh {1} ::: $(eval echo -e {1..$(wc -l data/${genome}_regions.txt | cut -d ' ' -f 1)})

exit
