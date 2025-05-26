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

mkdir -p gvcf-dadi-combined-2/

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
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/ERR12892801.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/ERR12892802.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074578.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074772.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074773.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074778.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074779.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074781.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074784.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074786.tgel1.all.raw.g.vcf.gz \
   --variant /data/CEM/smacklab/gelada_project/gvcf-all/LID_1074787.tgel1.all.raw.g.vcf.gz \
   -O gvcf-dadi-combined-2/${dataset}-cohort.CEN.SOU.g.vcf.gz

