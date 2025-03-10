#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="call all sites"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=128:00:00
#SBATCH --mem=160G

module load gatk-4.2.6.1-gcc-11.2.0

source scripts/_include_options.sh

gatk --java-options "-Xmx128g" GenotypeGVCFs \
   -R gvcf-dadi-combined/${dataset}-cohort.g.vcf.gz \
   -V ${combined_gvcfs} \
   --include-non-variant-sites \
   --sites-only-vcf-output \
   -O gvcf-dadi-combined/${dataset}.allsites.nogeno.vcf.gz
