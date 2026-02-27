#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="run vcftools pi"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=1

module load vcftools-0.1.14-gcc-11.2.0
source scripts/_include_options.sh

northern_indvs=$(paste -sd, data/dadi.north_all.96.txt)
central_indvs=$(paste -sd, data/dadi.central_all.27.txt)

mkdir -p pi_out

vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.vcf.gz \
		 --window-pi 50000 \
		 --window-pi-step 10000 \
         --minQ 20 \
         --max-missing 0.8 \
         --out pi_out/pi.autosomes.50kb-window.northern

vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.north_96.vcf.gz \
		 --window-pi 100000 \
		 --window-pi-step 10000 \
         --minQ 20 \
         --max-missing 0.8 \
         --out pi_out/pi.autosomes.100kb-window.northern

vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.central_27.vcf.gz \
		 --window-pi 100000 \
		 --window-pi-step 10000 \
         --minQ 20 \
         --max-missing 0.8 \
         --out pi_out/pi.autosomes.100kb-window.central

vcftools --gzvcf vcf-combined/dadi.tgel1.bootstrap.autosomes.pas.central_27.vcf.gz \
		 --window-pi 50000 \
		 --window-pi-step 10000 \
         --minQ 20 \
         --max-missing 0.8 \
         --out pi_out/pi.autosomes.50kb-window.central

