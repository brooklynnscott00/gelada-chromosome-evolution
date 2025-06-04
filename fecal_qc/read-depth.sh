#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="get southern read depth"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1

module load samtools-1.21-gcc-12.1.0
source scripts/_include_options.sh

samples="ERR12892801
ERR12892802
LID_1074575
LID_1074577
LID_1074578
LID_1074771
LID_1074772
LID_1074773
LID_1074774
LID_1074775
LID_1074777
LID_1074778
LID_1074779
LID_1074780
LID_1074781
LID_1074782
LID_1074783
LID_1074784
LID_1074785
LID_1074786
LID_1074787
LID_1074788
LID_1074789
"

sample=$(echo "$samples" | sed -n "${SLURM_ARRAY_TASK_ID}p")
bam="/data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${sample}.aligned-tgel1.sorted.mkdups.bam"

mkdir -p samtools-depth/

samtools depth -aa ${bam} | cut -f 3 | gzip > samtools-depth/${sample}.aligned-tgel1.sorted.mkdups.depth.gz

