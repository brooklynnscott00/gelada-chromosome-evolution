#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run vcftools Fst"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=public
#SBATCH --qos=public
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4

module load vcftools-0.1.14-gcc-11.2.0
source scripts/_include_options.sh

northern_indvs=$(paste -sd, data/dadi.north_all.96.txt)
central_indvs=$(paste -sd, data/dadi.central_all.27.txt)

mkdir -p fst_out

# vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.central_27.vcf.gz \
#          --weir-fst-pop data/dadi.north_all.96.txt \
#          --weir-fst-pop data/dadi.central_all.27.txt \
#          --fst-window-size 50000 \
#          --fst-window-step 10000 \
#          --minQ 20 \
#          --max-missing 0.8 \
#          --maf 0.01 \
#          --out fst_out/fst.autosomes.50kb-window.northern_central
# 
# vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.central_27.vcf.gz \
#          --weir-fst-pop data/dadi.north_all.96.txt \
#          --weir-fst-pop data/dadi.central_all.27.txt \
#          --fst-window-size 100000 \
#          --fst-window-step 10000 \
#          --minQ 20 \
#          --max-missing 0.8 \
#          --maf 0.01 \
#          --out fst_out/fst.autosomes.100kb-window.northern_central

vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.central_27.vcf.gz \
    --bed gff/Tgel_1.0_CDS.bed \
    --weir-fst-pop data/dadi.north_all.96.txt \
    --weir-fst-pop data/dadi.central_all.27.txt \
    --out fst_out/fst.CDS.northern-central

