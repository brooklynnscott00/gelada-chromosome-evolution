#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="low quality mask"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G

module load bedtools2-2.30.0-gcc-11.2.0
source scripts/_include_options.sh

bedtools subtract -header \
        -a dadi-vcf-1/${dataset}.NOR.CEN.22.merged.snv.autosomes_only.vcf.gz \
        -b dadi-vcf-1/${dataset}.NOR.CEN.22.merged.autosomes_only.vcf.gz > \
        dadi-vcf-1/NOR.CEN.low_quality_mask.vcf

bedtools subtract -header \
        -a dadi-vcf-2/${dataset}.CEN.SOU.22.merged.snv.autosomes_only.vcf.gz \
        -b dadi-vcf-2/${dataset}.CEN.SOU.22.merged.autosomes_only.vcf.gz > \
        dadi-vcf-2/CEN.SOU.low_quality_mask.vcf

