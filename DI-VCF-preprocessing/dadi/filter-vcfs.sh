#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter vcfs"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=4-00:00:00
#SBATCH --mem=128G

module load bcftools-1.14-gcc-11.2.0
source scripts/_include_options.sh

# filter for the individuals 
mkdir -p DI-vcf/
mkdir -p DI-vcf/dadi_2

grep 'North' data/gelada-metadata.txt | cut -f1 > data/dadi.north_all.96.txt
grep -E 'Central|Zoo' data/gelada-metadata.txt | grep -vE 'FRZ003|FRZ008|FRZ015' | cut -f1 > data/dadi.central_all.27.txt
grep -E 'South' data/gelada-metadata.txt | grep -vE 'LID_1074780' | cut -f1 > data/dadi.southern_all.22.txt

cat data/dadi.north_all.96.txt data/dadi.central_all.27.txt > data/dadi.north_96.central_27.txt
cat data/dadi.central_all.27.txt data/dadi.southern_all.22.txt > data/dadi.central_27.southern_22.txt

pairs=("north_96.central_27" "central_27.southern_22")
sample=${pairs[$SLURM_ARRAY_TASK_ID-1]}

bcftools view --samples-file dadi.${sample}.txt -Oz -o DI-vcf/dadi_2/dadi.tgel1.${sample}.whole_genome.pas_nofilter.vcf.gz vcf-final/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.vcf.gz
bcftools index DI-vcf/dadi_2/dadi.tgel1.${sample}.whole_genome.pas_nofilter.vcf.gz

# filter for autosomes
regions="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1
"

bcftools view --regions ${regions} -Oz -o DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.vcf.gz DI-vcf/dadi_2/dadi.tgel1.${sample}.whole_genome.pas_nofilter.vcf.gz
bcftools index DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.vcf.gz

# remove exons 10k extended 
module load bedtools2-2.30.0-gcc-11.2.0

bedtools subtract -header \
	-a DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.vcf.gz \
	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz > \
	DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.rm_exons_10k_extended.vcf

gzip DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.rm_exons_10k_extended.vcf

# remove repeats

bedtools subtract -header \
	-a DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.rm_exons_10k_extended.vcf.gz \
	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
	DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.rm_exons_10k_extended.rm_repeats.vcf

gzip DI-vcf/dadi_2/dadi.tgel1.${sample}.autosomes_only.pas_nofilter.rm_exons_10k_extended.rm_repeats.vcf
