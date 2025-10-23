#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="ssmcpp estimate central"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=68G
#SBATCH --export=NONE

mkdir -p smcpp_bootstrap/central_estimation/
mkdir -p smcpp_bootstrap/central_estimation_single
mkdir -p smcpp_bootstrap/central_estimation_single/${int}

int=$(printf %04d $SLURM_ARRAY_TASK_ID)

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
    estimate \
    -o smcpp_bootstrap/central_estimation_single/${int}/ \
    5.7e-09 \
    smcpp_bootstrap/central_smcformat/cen-*.${int}.smc.gz

mv smcpp_bootstrap/central_estimation_single/${int}/model.final.json smcpp_bootstrap/central_estimation/central.model.${int}.final.json
