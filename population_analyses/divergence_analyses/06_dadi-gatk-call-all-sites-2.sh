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

source scripts/_include_options.sh

java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar GenotypeGVCFs \
   -R gvcf-dadi-combined-2/${dataset}-cohort.CEN.SOU.g.vcf.gz \
   -V ${combined_gvcfs} \
   --include-non-variant-sites \
   --sites-only-vcf-output \
   -O gvcf-dadi-combined-2/${dataset}.CEN.SOU.allsites.nogeno.vcf.gz
