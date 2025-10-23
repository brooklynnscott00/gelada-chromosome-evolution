#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make SMC mask"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --mem=32G
#SBATCH --array=1

module load bedtools2-2.30.0-gcc-11.2.0
module load bcftools-1.14-gcc-11.2.0
source scripts/_include_options.sh

mkdir -p DI-vcf/smcpp_bootstrap/


regions="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1
"

bcftools view --regions ${regions} -O z -o DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter.vcf.gz vcf-final/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.vcf.gz

vcf=DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter
#north_all=$(grep 'North' data/gelada-metadata.txt | cut -f1 | paste -sd "," -)
central_all=$(grep -E 'Central|Zoo' data/gelada-metadata.txt | grep -vE 'FRZ003|FRZ008|FRZ015' | cut -f1)
#south_all=$(grep -E 'South' data/gelada-metadata.txt | cut -f1 | paste -sd "," -)

#bcftools view --samples ${north_all} -Oz -o ${vcf}.northern_96.vcf.gz ${vcf}.vcf.gz
bcftools view --samples ${central_all} -Oz -o ${vcf}.central_27.vcf.gz ${vcf}.vcf.gz
#bcftools view --samples ${south_all} -Oz -o ${vcf}.southern_22.vcf.gz ${vcf}.vcf.gz

#bcftools index ${vcf}.northern_96.vcf.gz
bcftools index ${vcf}.central_27.vcf.gz
#bcftools index ${vcf}.southern_22.vcf.gz

#bcftools view --exclude-uncalled -Oz -o ${vcf}.northern_96.exclude-uncalled.vcf.gz ${vcf}.northern_96.vcf.gz
bcftools view --exclude-uncalled -Oz -o ${vcf}.central_27.exclude-uncalled.vcf.gz ${vcf}.central_27.vcf.gz
#bcftools view --exclude-uncalled -Oz -o ${vcf}.southern_22.exclude-uncalled.vcf.gz ${vcf}.southern_22.vcf.gz

#bcftools index ${vcf}.northern_96.exclude-uncalled.vcf.gz
bcftools index ${vcf}.central_27.exclude-uncalled.vcf.gz
#bcftools index ${vcf}.southern_22.exclude-uncalled.vcf.gz

cut -f1,3 data/tgel1_chromosomes.bed > smcpp_bootstrap/tgel1_chromosomes.bed

#bedtools complement -i ${vcf}.northern_96.exclude-uncalled.vcf.gz -g smcpp_bootstrap/tgel1_chromosomes.bed > smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.nothern.complement.bed
bedtools complement -i ${vcf}.central_27.exclude-uncalled.vcf.gz -g smcpp_bootstrap/tgel1_chromosomes.bed > smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.central.complement.bed
#bedtools complement -i ${vcf}.southern_22.exclude-uncalled.vcf.gz -g smcpp_bootstrap/tgel1_chromosomes.bed > smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.southern.complement.bed
