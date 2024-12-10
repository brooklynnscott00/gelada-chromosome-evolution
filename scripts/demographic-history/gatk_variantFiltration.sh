
#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter variants"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G

module load gatk-4.2.6.1-gcc-11.2.0

genome_path="/scratch/klchiou/brooklynn/genome/Tgel_1.0.dna.fa"

gatk --java-options "-Xmx32g" VariantFiltration \
	--reference ${genome_path} \
	--output  /scratch/brscott4/gelada/data/gvcf-dadi-combined/final.quality_filtered.vcf.gz \
	--variant  /scratch/brscott4/gelada/data/gvcf-dadi-combined/final.vcf.gz \
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

