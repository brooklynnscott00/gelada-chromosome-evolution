 #!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="call variants"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load gatk-4.2.6.1-gcc-11.2.0

source scripts/include.sh

combined_gvcfs="/scratch/brscott4/gelada/data/gvcf-dadi-combined/cohort.g.vcf.gz"

gatk --java-options "-Xmx4g" GenotypeGVCFs \
   -R ${genome_path} \
   -V ${combined_gvcfs} \
   -O results/dadi-cohort.vcf.gz

