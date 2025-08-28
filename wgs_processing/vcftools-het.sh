#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="vcftools-het"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load vcftools-0.1.14-gcc-11.2.0
module load parallel-20220522-gcc-12.1.0

mkdir -p stats/vcftools-het-chr

chr=$(cut -f2 data/tgel1_windows.txt | uniq | tail -n+2 | sed -n ${SLURM_ARRAY_TASK_ID}p)
window=$(grep $chr data/tgel1_windows.txt | cut -f1)

slots=16

parallel -j $slots scripts/vcftools-het-single.sh {1} {2} ::: $window ::: $chr
