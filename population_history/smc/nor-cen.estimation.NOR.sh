#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="ssmcpp-estimate-NOR"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=68G
#SBATCH --export=NONE

mkdir -p smcpp_results/nor-cen/quality_mask_output

inputDirectory="smcpp_results/nor-cen/smcformat_quality_mask/"
outputDirectory="smcpp_results/nor-cen/quality_mask_output"
mutationRate=5e-09

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
    estimate \
    -o ${outputDirectory}/model.north \
    ${mutationRate} \
    ${inputDirectory}nor*
