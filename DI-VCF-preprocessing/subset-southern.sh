#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter cen-sou vcf for southern animals"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load bcftools-1.14-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p vcf

southern='ERR12892801,ERR12892802,LID_1074578,LID_1074772,LID_1074773,LID_1074778,LID_1074779,LID_1074781,LID_1074784,LID_1074786,LID_1074787'

bcftools view -s ${southern} -O z -o DI-vcf/southern.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz DI-vcf/cen-sou.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz

