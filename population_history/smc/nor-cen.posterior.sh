#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="smcpp-posterior-nor-cen"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=164G
#SBATCH --export=NONE

mkdir -p smcpp_results/nor-cen/posterior

smc_north=$(printf "%s " smcpp_results/nor-cen/smcformat_no_mask/nor*)
smc_central=$(printf "%s " smcpp_results/nor-cen/smcformat_no_mask/nor*)

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
    posterior \
	--cores 16 \
	-v \
	smcpp_results/nor-cen/split_no_mask/model.final.json \
	smcpp_results/nor-cen/posterior/split-estimate.posterior.arrays.npz \
	${smc_north} ${smc_central}

# singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
#     posterior \
# 	--cores 16 \
# 	-v \
# 	--heatmap smcpp_results/nor-cen/posterior/northern-model.posterior.plot.pdf \
# 	--colorbar \
# 	smcpp_results/nor-cen/estimate_no_mask/north/model.final.json \
# 	smcpp_results/nor-cen/posterior/northern-model.estimate.arrays.npz \
# 	${smc_north}
# 
# singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
#     posterior \
# 	--cores 16 \
# 	-v \
# 	--heatmap smcpp_results/nor-cen/posterior/central-model.posterior.plot.pdf \
# 	--colorbar \
# 	smcpp_results/nor-cen/estimate_no_mask/central/model.final.json \
# 	smcpp_results/nor-cen/posterior/central-model.estimate.arrays.npz \
# 	${smc_central}
