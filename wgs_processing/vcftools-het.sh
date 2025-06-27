#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="mosdepth"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

module load vcftools-0.1.14-gcc-11.2.0

mkdir -p stats/vcftools-het-chr

chr=$(cut -f1 data/tgel1_autosomes.bed | sed -n ${SLURM_ARRAY_TASK_ID}p)

vcftools --gzvcf vcf-chr/dadi.tgel1.bootstrap.chr${chr}.snv.vcf.gz \
	--het \
	--out stats/vcftools-het-chr/${chr}

