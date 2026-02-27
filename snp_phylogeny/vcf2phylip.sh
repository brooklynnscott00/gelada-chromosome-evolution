#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="filter-vcf"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=64G

module load mamba/latest
source activate bioawk 

mkdir -p iqtree_out
mkdir -p iqtree_out/phy

/scratch/brscott4/programs/vcf2phylip/vcf2phylip.py -i iqtree_out/vcf/merged.autosomes.missing_0.8.thinned_10k.snps_only.vcf.gz \
	-o FIL009 \
	--output-folder /scratch/brscott4/gelada-chromosome-evolution/iqtree_out/phy/


