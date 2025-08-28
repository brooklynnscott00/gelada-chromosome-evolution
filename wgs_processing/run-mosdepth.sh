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

module load mamba/latest
source activate mosdepth

mkdir -p stats/mosdepth-out/

id=$(sed -n ${SLURM_ARRAY_TASK_ID}p data/sample_list.txt)

mosdepth stats/mosdepth-out/${id} /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${id}.aligned-tgel1.sorted.mkdups.bam
mosdepth --by 1 stats/mosdepth-out/${id}.per-base /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${id}.aligned-tgel1.sorted.mkdups.bam
mosdepth --thresholds 1 --by 1 stats/mosdepth-out/${id}.threshold /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${id}.aligned-tgel1.sorted.mkdups.bam
