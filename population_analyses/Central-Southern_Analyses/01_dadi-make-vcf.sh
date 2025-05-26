#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make vcf dadi"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

source scripts/_include_options.sh

# define dadi sample list
samples='data/dadi.sample_list.CEN.SOU.txt'

chr=$(cut -d ':' -f 1 data/${genome}_regions.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p)

mkdir -p Central-Southern_dadi-vcf/
mkdir -p Central-Southern_dadi-vcf-chr/

# filter vcfs for only the samples inlcuded in the dadi list
bcftools view -S ${samples} vcf-chr/${dataset}.${genome}.bootstrap.chr${chr}.pas.vcf.gz \
  | bgzip -c > Central-Southern_dadi-vcf-chr/${dataset}.CEN.SOU.22.chr${chr}.pas.vcf.gz

# concat and index
if [ "$SLURM_ARRAY_TASK_ID" -eq 22 ]; then
	ls Central-Southern_dadi-vcf-chr/*.vcf.gz | sort -V > data/dadi_vcf_list-2.txt
	bcftools concat -Oz -o Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.vcf.gz -f data/${dataset}_vcf_list-2.txt
	bcftools index Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.vcf.gz
fi

# no quality filters
bcftools view -S ${samples} vcf-chr/${dataset}.${genome}.bootstrap.chr${chr}.snv.vcf.gz \
  | bgzip -c > Central-Southern_dadi-vcf-chr/${dataset}.CEN.SOU.22.chr${chr}.snv.vcf.gz

# concat and index
if [ "$SLURM_ARRAY_TASK_ID" -eq 22 ]; then
	ls Central-Southern_dadi-vcf-chr/*snv.vcf.gz | sort -V > data/${dataset}_vcf_list-2.snv.txt
	bcftools concat -Oz -o Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.snv.vcf.gz -f data/${dataset}_vcf_list-2.snv.txt
	bcftools index Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.snv.vcf.gz
fi
