#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter-vcf"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=64G

module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

mkdir -p iqtree_out
mkdir -p iqtree_out/vcf

regions="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1
"

bcftools view --samples ERR12892802,GUA003,SKR015,CHK001,ERR12892801,GUA002 \
	-Oz -o iqtree_out/vcf/vcf1.autosomes.pas.vcf.gz \
	/scratch/brscott4/gelada-chromosome-evolution/vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz

tabix -p vcf iqtree_out/vcf/vcf1.autosomes.pas.vcf.gz

bcftools view --samples FIL009 \
	-Oz -o iqtree_out/vcf/vcf2.whole_genome.vcf.gz \
	/data/CEM/smacklab/gelada_project/vcf/final/gelada.tgel1.filtered.all.step2.vcf.gz 

tabix -p vcf iqtree_out/vcf/vcf2.whole_genome.vcf.gz

bcftools view --regions ${regions} \
	-Oz -o iqtree_out/vcf/vcf2.autosomes.vcf.gz \
	iqtree_out/vcf/vcf2.whole_genome.vcf.gz 

tabix -p vcf iqtree_out/vcf/vcf2.autosomes.vcf.gz

bcftools view -m2 \
	-M2 \
	-i 'F_MISSING=0' \
	-v snps \
	-f .,PASS \
	-Oz -o iqtree_out/vcf/vcf1.autosomes.pas.snps.vcf.gz \
	iqtree_out/vcf/vcf1.autosomes.pas.vcf.gz

bcftools view -m2 \
	-M2 \
	-i 'F_MISSING=0' \
	-v snps \
	-f .,PASS \
	-Oz -o iqtree_out/vcf/vcf2.autosomes.pas.snps.vcf.gz \
	iqtree_out/vcf/vcf2.autosomes.vcf.gz

tabix -p vcf iqtree_out/vcf/vcf1.autosomes.pas.snps.vcf.gz
tabix -p vcf iqtree_out/vcf/vcf2.autosomes.pas.snps.vcf.gz

