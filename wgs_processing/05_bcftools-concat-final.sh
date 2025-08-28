#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="final vcf"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --export=NONE

source scripts/_include_options.sh

mkdir -p vcf-final/

module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

if [ $SLURM_ARRAY_TASK_ID -eq 1 ]; then
    bcftools concat -Oz -o vcf-final/dadi.tgel1.bootstrap.autosomes.snv.vcf.gz $(for i in $(cut -f1 data/tgel1_autosomes.bed); do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf $i | xargs).snv.vcf.gz; done)
    bcftools index -t vcf-final/dadi.tgel1.bootstrap.autosomes.snv.vcf.gz

elif [ $SLURM_ARRAY_TASK_ID -eq 2 ]; then
    bcftools concat -Oz -o vcf-final/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz $(for i in $(cut -f1 data/tgel1_autosomes.bed); do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf $i | xargs).pas.vcf.gz; done)
    bcftools index -t vcf-final/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz

elif [ $SLURM_ARRAY_TASK_ID -eq 3 ]; then
    bcftools concat -Oz -o vcf-final/dadi.tgel1.bootstrap.whole_genome.snv.vcf.gz $(for i in $(cut -f1 data/tgel1_chromosomes.bed); do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf $i | xargs).snv.vcf.gz; done)
    bcftools index -t vcf-final/dadi.tgel1.bootstrap.whole_genome.snv.vcf.gz

elif [ $SLURM_ARRAY_TASK_ID -eq 4 ]; then
    bcftools concat -Oz -o vcf-final/dadi.tgel1.bootstrap.whole_genome.pas.vcf.gz $(for i in $(cut -f1 data/tgel1_chromosomes.bed); do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf $i | xargs).pas.vcf.gz; done)
    bcftools index -t vcf-final/dadi.tgel1.bootstrap.whole_genome.pas.vcf.gz
fi
