#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="subsest bams"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --mem=4G
#SBATCH --exclusive

id=$(sed -n ${SLURM_ARRAY_TASK_ID}p data/sample_list.txt)
regions=$(echo $(cat data/tgel1_regions.txt))

module load gnu-parallel/latest
module load samtools-1.21-gcc-12.1.0

parallel scripts/subset-bams-single.sh {1} {2} ::: $id ::: $regions

exit
