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
#SBATCH --exclusive
#SBATCH --mem=0

module load gnu-parallel/latest
module load samtools-1.16-gcc-11.2.0

# Calculate number of slots available
slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)

# Set the interval
if [ -z "$1" ]; then interval=1000; else interval=$1; fi

start_line=$(((${SLURM_ARRAY_TASK_ID}-1)*${interval}+1))
end_line=$(((${SLURM_ARRAY_TASK_ID})*${interval}))

if [ $end_line -gt $(cat ../../data/sample_region_list.txt | wc -l) ]; then
end_line=$(cat ../../data/sample_region_list.txt | wc -l)
fi

# for i in {1..100}; do
# echo $i' '$interval' '$((($i-1)*${interval}+1))' '$((($i)*${interval}))
# done

parallel -j $slots subset-bam-single.sh {1} ::: $(eval echo -e {${start_line}..${end_line}})

exit
