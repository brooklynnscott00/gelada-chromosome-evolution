#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-repeats"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bedtools2-2.30.0-gcc-11.2.0

source scripts/_include_options.sh

# path to repetitive regions 
repeats="/scratch/klchiou/brooklynn/genomes/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed"

bedtools subtract -header \
	-a dadi-vcf/${dataset}.NOR.CEN.22.merged.autosomes_only.vcf.gz \
	-b ${repeats} > \
	dadi-vcf/${dataset}.NOR.CEN.22.merged.autosomes_only.rm_repeats.vcf

gzip dadi-vcf/${dataset}.NOR.CEN.22.merged.autosomes_only.rm_repeats.vcf
