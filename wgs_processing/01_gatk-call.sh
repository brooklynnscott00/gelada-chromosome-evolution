#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="gatk-hap"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=7-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --export=NONE

# extract correspinding sample ID 
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p data/sample_list.txt)
regions=$(echo $(cat data/tgel1_regions.txt))

source scripts/_include_options.sh

# determine the number of cpus available
#slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)

module load perl-5.26.2-gcc-12.1.0
module load parallel-20220522-gcc-12.1.0
module load jdk-12.0.2_10-gcc-12.1.0
module load htslib-1.21-gcc-11.2.0
module load shpc/python/3.9.2-slim/module
module load samtools-1.21-gcc-12.1.0

# use gnu parallel to run on multiple regions in parallel
# -j $slots , run on the number of available cpus
parallel scripts/gatk-call-variants-single.sh {1} {2} ::: $id ::: $regions

# make directory to store final vcfs
mkdir -p gvcf-all/
module load bcftools-1.14-gcc-11.2.0

# merge all regions vcf files into a single vcf
mkdir -p gvcf-list
ls gvcf/*${id}*.gz > gvcf-list/${id}-region-list.txt

if [ "$(wc -l < gvcf-list/${id}-region-list.txt)" -eq 947 ]; then

bcftools concat -Oz -o gvcf-all/${id}.tgel1.all.raw.g.vcf.gz --file-list gvcf-list/${id}-region-list.txt

bcftools sort gvcf-all/${id}.tgel1.all.raw.g.vcf.gz -Oz \
    -o gvcf-all/${id}.tgel1.all.raw.sorted.g.vcf.gz

tabix -p vcf gvcf-all/${id}.tgel1.all.raw.sorted.g.vcf.gz

else
exit 1
fi
