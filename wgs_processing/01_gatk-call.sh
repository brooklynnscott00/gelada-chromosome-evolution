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

source scripts/_include_options.sh

# determine the number of cpus available
slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)

# if a second command line argument is provided and greater than 0, the regions file is read in reverse order, otherwise read as normal order
if [ ! -z $2 ] && [ $2 -gt 0 ]; then
regions=$(echo $(tac data/${genome}_regions.txt))
else
regions=$(echo $(cat data/${genome}_regions.txt))
fi

module load perl-5.26.2-gcc-12.1.0
module load parallel-20220522-gcc-12.1.0
module load jdk-12.0.2_10-gcc-12.1.0
module load htslib-1.21-gcc-11.2.0
module load shpc/python/3.9.2-slim/module
module load samtools-1.21-gcc-12.1.0

# use gnu parallel to run on multiple regions in parallel
# -j $slots , run on the number of available cpus
parallel -j $slots scripts/gatk-call-variants-single.sh {1} {2} ::: $id ::: $regions

# make directory to store final vcfs
mkdir -p /data/CEM/smacklab/gelada_project/gvcf-all
module load bcftools-1.14-gcc-11.2.0

# merge all regions vcf files into a single vcf

bcftools concat -Oz -o /data/CEM/smacklab/gelada_project/gvcf-all/${id}.${genome}.all.raw.g.vcf.gz $(for i in $(seq $(wc -l data/${genome}_regions.txt | cut -d ' ' -f 1)); do int=$(printf %04d $i); chr=$(sed -n ${i}p data/${genome}_regions.txt | cut -d : -f 1); echo /data/CEM/smacklab/gelada_project/gvcf/${id}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz; done)

bcftools sort /data/CEM/smacklab/gelada_project/gvcf-all/${id}.${genome}.all.raw.g.vcf.gz -Oz \
    -o /data/CEM/smacklab/gelada_project/gvcf-all/${id}.${genome}.all.raw.sorted.g.vcf.gz

# index
tabix -p vcf /data/CEM/smacklab/gelada_project/gvcf-all/${id}.${genome}.all.raw.sorted.g.vcf.gz

exit
