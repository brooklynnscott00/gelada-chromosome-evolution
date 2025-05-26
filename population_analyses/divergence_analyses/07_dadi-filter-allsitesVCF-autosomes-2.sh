#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bcftools filter for autosomes"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bcftools-1.14-gcc-11.2.0
source scripts/_include_options.sh

regions="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1
"

bcftools view -o -Oz gvcf-dadi-combined-2/${dataset}.CEN.SOU.allsites.nogeno.autosomes.vcf.gz -r $regions gvcf-dadi-combined-2/${dataset}.CEN.SOU.allsites.nogeno.vcf.gz
