#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make low quality mask"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G

module load bedtools2-2.30.0-gcc-11.2.0
module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

source scripts/_include_options.sh

int=$(printf %04d $SLURM_ARRAY_TASK_ID)
region=$(sed -n ${i}p data/${genome}_regions.txt)
chr=$(echo $region | cut -d : -f 1)

pairs=("north_96.central_27" "central_27.southern_22")
sample=${pairs[$SLURM_ARRAY_TASK_ID-1]}

bcftools view -m2 -M2 -v snps -f .,PASS -T ^ -Oz \
  -o vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.fail.vcf.gz \
  vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz

