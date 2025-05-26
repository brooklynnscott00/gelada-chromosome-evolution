#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name='filter variants'
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

source scripts/_include_options.sh
mkdir -p vcf

if [ "$SLURM_ARRAY_TASK_ID" -eq 1 ]; then
	java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar VariantFiltration \
		--reference /scratch/brscott4/gelada/data/genome/${genome_path} \
		--output  vcf/nor-cen.quality-filtered.vcf.gz \
		--variant  vcf/nor-cen.vcf.gz \
		--filter-name "QD" \
		--filter "QD < 2.0" \
		--filter-name "MQ" \
		--filter "MQ < 40.0" \
		--filter-name "FS" \
		--filter "FS > 60.0" \
		--filter-name "MQRS" \
		--filter "MQRankSum < -12.5" \
		--filter-name "RPRS" \
		--filter "ReadPosRankSum < -8.0" \
		--filter-name "SOR" \
		--filter "SOR > 3.0" \
		--missing-values-evaluate-as-failing
else
	java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar VariantFiltration \
		--reference /scratch/brscott4/gelada/data/genome/${genome_path} \
		--output  vcf/cen-sou.quality-filtered.vcf.gz \
		--variant  vcf/cen-sou.vcf.gz \
		--filter-name "QD" \
		--filter "QD < 2.0" \
		--filter-name "MQ" \
		--filter "MQ < 40.0" \
		--filter-name "FS" \
		--filter "FS > 60.0" \
		--filter-name "MQRS" \
		--filter "MQRankSum < -12.5" \
		--filter-name "RPRS" \
		--filter "ReadPosRankSum < -8.0" \
		--filter-name "SOR" \
		--filter "SOR > 3.0" \
		--missing-values-evaluate-as-failing
fi
