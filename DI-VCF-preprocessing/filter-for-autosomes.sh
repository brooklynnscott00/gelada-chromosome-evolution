#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter gvcf for autosomes"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=4-00:00:00
#SBATCH --mem=128G

module load bcftools-1.14-gcc-11.2.0
source scripts/_include_options.sh

regions="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1
"

mkdir -p vcf

if [ "$SLURM_ARRAY_TASK_ID" -eq 1 ]; then
	bcftools view --regions ${regions} -O z -o vcf/cen-sou.quality-filtered.autosomes_only.vcf.gz vcf/cen-sou.quality-filtered.vcf.gz
	bcftools view --regions ${regions} -O z -o gvcf/cen-sou.cohort.autosomes_only.g.vcf gvcf/cen-sou.cohort.g.vcf
else
	bcftools view --regions ${regions} -O z -o vcf/nor-cen.quality-filtered.autosomes_only.vcf.gz vcf/nor-cen.quality-filtered.vcf.gz
	bcftools view --regions ${regions} -O z -o gvcf/nor-cen.cohort.autosomes_only.g.vcf gvcf/nor-cen.cohort.g.vcf
fi
