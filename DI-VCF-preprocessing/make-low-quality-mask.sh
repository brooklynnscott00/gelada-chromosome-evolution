#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make low quality mask"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=24G

module load bedtools2-2.30.0-gcc-11.2.0
module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p vcf

regions="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1
"

bedtools subtract -header \
	-a vcf/cen-sou.vcf.gz \
	-b vcf/cen-sou.quality-filtered.vcf.gz > \
	vcf/cen-sou.low_quality_mask.vcf

bgzip vcf/cen-sou.low_quality_mask.vcf

bcftools index vcf/cen-sou.low_quality_mask.vcf.gz
bcftools view --regions ${regions} -Oz -o vcf/cen-sou.autosomes.low_quality_mask.vcf.gz vcf/cen-sou.low_quality_mask.vcf.gz

bedtools subtract -header \
	-a vcf/nor-cen.vcf.gz \
	-b vcf/nor-cen.quality-filtered.vcf.gz > \
	vcf/nor-cen.low_quality_mask.vcf

bgzip vcf/nor-cen.low_quality_mask.vcf

bcftools index vcf/nor-cen.low_quality_mask.vcf.gz
bcftools view --regions ${regions} -Oz -o vcf/nor-cen.autosomes.low_quality_mask.vcf.gz vcf/nor-cen.low_quality_mask.vcf.gz
