#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-exons"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bedtools2-2.30.0-gcc-11.2.0

source scripts/_include_options.sh

# path to exons
exons="/scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz"

bedtools subtract -header \
	-a Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.autosomes_only.rm_repeats.vcf.gz \
	-b ${exons} > \
	Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf

gzip Central-Southern_dadi-vcf/${dataset}.CEN.SOU.22.merged.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf
