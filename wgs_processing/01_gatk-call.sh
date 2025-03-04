#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="gatk-hap"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=7-00:00:00
#SBATCH --mem=0
#SBATCH --exclusive

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

# module load perl-5.31.4-intel-19.1.3.304
# module load gnu-parallel/latest
# module load gatk-4.2.6.1-gcc-11.2.0
# module load jdk-12.0.2_10-gcc-12.1.0
# module load htslib-1.16-gcc-11.2.0
# loaf modules
module load perl/5.26.0
module load parallel/latest
module load gatk/4.2.5.0
module load java/latest
module load htslib/1.15.1

# use gnu parallel to run on multiple regions in parallel
# -j $slots , run on the number of available cpus
parallel -j $slots scripts/gatk-call-variants-single.sh {1} {2} ::: $id ::: $regions

# make directory to store final vcfs
mkdir -p gvcf-all
module load bcftools/1.15.1

# merge all regions vcf files into a single vcf
bcftools concat -Oz -o gvcf-all/${id}.${genome}.all.raw.g.vcf.gz $(for i in $(seq $(wc -l data/${genome}_regions.txt | cut -d ' ' -f 1)); do int=$(printf %04d $i); chr=$(sed -n ${i}p data/${genome}_regions.txt | cut -d : -f 1); echo gvcf/${id}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz; done)
# index
tabix -p vcf gvcf-all/${id}.${genome}.all.raw.g.vcf.gz

exit
