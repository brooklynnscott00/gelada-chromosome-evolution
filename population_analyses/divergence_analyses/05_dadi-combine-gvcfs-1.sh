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

mkdir -p gvcf-dadi-combined-1/

source scripts/_include_options.sh

java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar CombineGVCFs \
   -R /scratch/brscott4/gelada/data/genome/${genome_path} \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/GUA001.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/GUA002.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/GUA003.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ001.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ002.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ003.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ004.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ005.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ006.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ007.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/FRZ009.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/CHK001.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/CHK002.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/CHK003.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR005.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR007.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR010.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR013.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR022.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR030.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR038.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/SKR039.tgel1.all.raw.g.vcf.gz \
   -O gvcf-dadi-combined-1/${dataset}-cohort.NOR.CEN.g.vcf.gz
