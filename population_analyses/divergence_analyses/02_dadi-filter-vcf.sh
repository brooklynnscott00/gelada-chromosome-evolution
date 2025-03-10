#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="bedtools-subtract-repeats"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=8G

module load bcftools-1.14-gcc-11.2.0

source scripts/_include_options.sh

# need to combine all vcfs in this directory except whichever one has the X chromsoome in the name 


chr=$(cut -d ':' -f 1 data/${genome}_regions.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p)
chr_print=$(printf %02d $chr 2> >(grep -v 'invalid number'))

if [ $chr_print = "00" ]; then
chr_out=$chr
chr_print=$chr
else
chr_out=$chr_print
fi 

dadi-vcf/dadi.NOR.CEN.22.ch${chr_out}.pas.vcf.gz