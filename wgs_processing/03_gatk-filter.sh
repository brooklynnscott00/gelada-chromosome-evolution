#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="gatk-vfl"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --time=4:00:00
#SBATCH --mem=0
#SBATCH --exclusive

slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)

source scripts/_include_options.sh

# module load perl-5.31.4-intel-19.1.3.304
# module load gnu-parallel/latest
# module load gatk-4.2.6.1-gcc-11.2.0
# module load jdk-12.0.2_10-gcc-12.1.0
# module load bcftools-1.14-gcc-11.2.0
# module load htslib-1.16-gcc-11.2.0

module load perl/5.26.0
module load parallel/20211022
module load gatk/4.2.5.0
module load java/8u92
module load bcftools/1.15.1
module load htslib/1.15.1

parallel -j $slots scripts/gatk-filter-variants-single.sh {1} ::: $(eval echo -e {1..$(wc -l data/${genome}_regions.txt | cut -d ' ' -f 1)})

exit
