#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make neutral regions bed"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=100G

module load bedtools2-2.30.0-gcc-11.2.0

bedtools subtract -a DI-gvcf/cen-sou.cohort.autosomes_only.merged.g.bed -b DI-vcf/cen-sou.low_quality_mask.bed \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz > \
  DI-gvcf/cen-sou.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed

bedtools subtract -a DI-gvcf/nor-cen.cohort.autosomes_only.merged.g.bed -b DI-vcf/nor-cen.low_quality_mask.bed \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz > \
  DI-gvcf/nor-cen.cohort.autosomes_only.merged.pass.rm_repeats.rm_exons_10k_extended.g.bed

