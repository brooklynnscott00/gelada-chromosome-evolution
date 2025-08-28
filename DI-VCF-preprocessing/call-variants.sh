#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="call variants"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

source scripts/_include_options.sh
mkdir -p vcf

if [ "$SLURM_ARRAY_TASK_ID" -eq 1 ]; then
  echo "Running GenotypeGVCFs for north/central"
  java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar GenotypeGVCFs \
     -R /scratch/brscott4/gelada/data/genome/${genome_path} \
     -V DI-gvcf/nor-cen.cohort.g.vcf \
     -O DI-vcf/nor-cen.vcf.gz
else
  echo "Running GenotypeGVCFs for central/southern"
  java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar GenotypeGVCFs \
     -R /scratch/brscott4/gelada/data/genome/${genome_path} \
     -V DI-gvcf/cen-sou.cohort.g.vcf \
     -O DI-vcf/cen-sou.vcf.gz
fi
