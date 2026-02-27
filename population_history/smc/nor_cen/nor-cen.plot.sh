#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="estimate-split-time"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --mem=64G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

mkdir -p smcpp_results/nor-cen/plot_no_mask

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
	plot \
	-g 11.67 -c \
	smcpp_results/nor-cen/plot_no_mask/nor-cen.joint.pdf \
	smcpp_results/nor-cen/split_no_mask/model.final.json
