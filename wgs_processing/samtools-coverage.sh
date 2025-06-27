#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="mosdepth"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load samtools-1.21-gcc-12.1.0

mkdir -p stats/
mkdir -p stats/samtools-coverage/

id=$(sed -n ${SLURM_ARRAY_TASK_ID}p data/sample_list.txt)

samtools coverage -o stats/samtools-coverage/${id}.cov /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${id}.aligned-tgel1.sorted.mkdups.bam
