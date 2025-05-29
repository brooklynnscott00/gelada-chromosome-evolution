#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="Fst north"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=4

export PATH=$PATH:~/programs/angsd/
source scripts/_include_options.sh

mkdir -p angsd-saf/

angsd \
	-b data/bam-lists/northern.txt \
	-anc /scratch/brscott4/gelada/data/genome/${genome_path} \
	-out angsd-saf/angsd-northern \
	-dosaf 1 \
	-gl 1 \
	-nInd 106
