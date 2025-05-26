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
#SBATCH --mem=32G

module load bedtools2-2.30.0-gcc-11.2.0

bedtools subtract -a gvcf-dadi-combined-1/dadi-cohort.NOR.CEN.merged.g.bed -b dadi-vcf-1/NOR.CEN.low_quality_mask.vcf \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz > \
  gvcf-dadi-combined-1/dadi-cohort.NOR.CEN.pass.biallelic.rm_repeats.rm_exons_10k_extended.bed

bedtools subtract -a gvcf-dadi-combined-2/dadi-cohort.CEN.SOU.merged.g.bed -b dadi-vcf-2/CEN.SOU.low_quality_mask.vcf \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed \
  | bedtools subtract -a stdin -b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz > \
  gvcf-dadi-combined-2/dadi-cohort.CEN.SOU.pass.biallelic.rm_repeats.rm_exons_10k_extended.bed
