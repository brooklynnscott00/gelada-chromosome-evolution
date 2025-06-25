#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="vcf2smc-fs-12"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE

mkdir -p smcpp_results/nor-cen/split

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
	split \
	-o smcpp_results/nor-cen/split smcpp_results/nor-cen/quality_mask_output/model.north/model.final.json smcpp_results/nor-cen/quality_mask_output/model.central/model.final.json smcpp_results/nor-cen/joint_fs/*.smc.gz

