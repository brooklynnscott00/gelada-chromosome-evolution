#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter gvcf for cohorts"
#SBATCH --output=out/slurm-%A_a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load bcftools-1.14-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p gvcf

if [ "$SLURM_ARRAY_TASK_ID" -eq 1 ]; then
	bcftools view --samples-file data/dadi.sample_list.NOR.CEN.txt -O z -o DI-gvcf/nor-cen.cohort.g.vcf DI-gvcf/cohort.g.vcf.gz
else
	bcftools view --samples-file data/dadi.sample_list.CEN.SOU.txt -O z -o DI-gvcf/cen-sou.cohort.g.vcf DI-gvcf/cohort.g.vcf.gz
fi
