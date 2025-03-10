#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="combine-gvcfs-dadi"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=48:00:00
#SBATCH --mem=32G

module load gatk-4.2.6.1-gcc-11.2.0

mkdir -p gvcf-dadi-combined/

source scripts/_include_options.sh

gatk CombineGVCFs \
   -R ${genome_path} \
   --variant gvcf-all/GUA001.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/GUA002.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/GUA003.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ001.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ002.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ003.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ004.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ005.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ006.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ007.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/FRZ009.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/CHK001.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/CHK002.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/CHK003.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR005.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR007.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR010.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR013.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR022.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR030.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR038.tgel1.all.raw.g.vcf.gz \
   --variant gvcf-all/SKR039.tgel1.all.raw.g.vcf.gz \
   -O gvcf-dadi-combined/${dataset}-cohort.g.vcf.gz
