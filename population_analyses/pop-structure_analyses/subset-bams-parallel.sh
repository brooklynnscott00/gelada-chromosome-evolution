#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="samview-parallel"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --mem=32G
#SBATCH --cpus-per-task=12

module load parallel-20220522-gcc-12.1.0
module load samtools-1.16-gcc-11.2.0

# Set the interval
if [ -z "$1" ]; then interval=1000; else interval=$1; fi

start_line=$(((${SLURM_ARRAY_TASK_ID}-1)*${interval}+1))
end_line=$(((${SLURM_ARRAY_TASK_ID})*${interval}))

if [ $end_line -gt $(cat data/sample_region_list_final.txt | wc -l) ]; then
end_line=$(cat data/sample_region_list_final.txt | wc -l)
fi

parallel -j 12 scripts/subset-bams-single.sh {1} ::: $(eval echo -e {${start_line}..${end_line}})

exit
