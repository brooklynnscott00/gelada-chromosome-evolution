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

mkdir -p vcf-final-2/

module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

if [ $SLURM_ARRAY_TASK_ID -eq 1 ]; then
    bcftools concat -Oz -o vcf-final-2/dadi.tgel1.bootstrap.autosomes.snv.vcf.gz $(for i in 1:21; do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf "%02d" $i | xargs).snv.vcf.gz; done)
    bcftools sort -Oz -o vcf-final-2/dadi.tgel1.bootstrap.autosomes.snv.sorted.vcf.gz vcf-final-2/dadi.tgel1.bootstrap.autosomes.snv.vcf.gz
    bcftools index -t vcf-final-2/dadi.tgel1.bootstrap.autosomes.snv.sorted.vcf.gz

elif [ $SLURM_ARRAY_TASK_ID -eq 2 ]; then
    bcftools concat -Oz -o vcf-final-2/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz $(for i in 1:21; do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf "%02d" $i | xargs).pas.vcf.gz; done)
    bcftools sort -Oz -o vcf-final-2/dadi.tgel1.bootstrap.autosomes.pas.sorted.vcf.gz vcf-final-2/dadi.tgel1.bootstrap.autosomes.pas.vcf.gz
    bcftools index -t vcf-final-2/dadi.tgel1.bootstrap.autosomes.pas.sorted.vcf.gz

elif [ $SLURM_ARRAY_TASK_ID -eq 3 ]; then
    bcftools concat -Oz -o vcf-final-2/dadi.tgel1.bootstrap.whole_genome.snv.vcf.gz $(for i in 1:22; do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf "%02d" $i | xargs).snv.vcf.gz; done)
    bcftools sort -Oz -o vcf-final-2/dadi.tgel1.bootstrap.whole_genome.snv.sorted.vcf.gz vcf-final-2/dadi.tgel1.bootstrap.whole_genome.snv.vcf.gz
    bcftools index -t vcf-final-2/dadi.tgel1.bootstrap.whole_genome.snv.sorted.vcf.gz

elif [ $SLURM_ARRAY_TASK_ID -eq 4 ]; then
    bcftools concat -Oz -o vcf-final-2/dadi.tgel1.bootstrap.whole_genome.pas.vcf.gz $(for i in 1:22; do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf "%02d" $i | xargs).pas.vcf.gz; done)
    bcftools sort -Oz -o vcf-final-2/dadi.tgel1.bootstrap.whole_genome.pas.sorted.vcf.gz vcf-final-2/dadi.tgel1.bootstrap.whole_genome.pas.vcf.gz
    bcftools index -t vcf-final-2/dadi.tgel1.bootstrap.whole_genome.pas.sorted.vcf.gz

# elif [ $SLURM_ARRAY_TASK_ID -eq 5 ]; then
#     bcftools concat -Oz -o vcf-final-2/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.vcf.gz $(for i in 1:22; do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf "%02d" $i | xargs).pas_nofilter.sorted.vcf.gz; done)
#     bcftools index -t vcf-final-2/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.vcf.gz
# 
# elif [ $SLURM_ARRAY_TASK_ID -eq 6 ]; then
#     bcftools concat -Oz -o vcf-final-2/dadi.tgel1.bootstrap.whole_genome.snv_nofilter.vcf.gz $(for i in 1:22; do echo vcf-chr/dadi.tgel1.bootstrap.chr$(printf "%02d" $i | xargs).snv_nofilter.sorted.vcf.gz; done)
#     bcftools index -t vcf-final-2/dadi.tgel1.bootstrap.whole_genome.snv_nofilter.vcf.gz

fi
