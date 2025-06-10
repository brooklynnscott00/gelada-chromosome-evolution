#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make neutral regions bed"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G


bedtools subtract -a data/gvcf-dadi-combined/final.allsites.nogeno.filtered.again.merge.bed -b data/gvcf-dadi-combined/low_quality_mask.vcf.gz \
  | bedtools subtract -a stdin -b /scratch/klchiou/brooklynn/genomes/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed \
  | bedtools subtract -a stdin -b /scratch/klchiou/brooklynn/genomes/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons_10k_extended.gtf.gz > \
  data/gvcf-dadi-combined/final.allsites.nogeno.filtered.pass.biallelic.rm_repeats.rm_exons_10k_extended.bed