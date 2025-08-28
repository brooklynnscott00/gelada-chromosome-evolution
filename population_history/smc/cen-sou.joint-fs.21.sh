#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="vcf2smc-fs-12"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --export=NONE
#SBATCH --array=68-88

mkdir -p smcpp_results/cen-sou/joint_fs_no_mask

sampleList=("ERR12892801" "ERR12892802" "LID_1074578" "LID_1074772" "LID_1074773" "LID_1074778" "LID_1074779" "LID_1074781" "LID_1074784" "LID_1074786" "LID_1074787")

northern='CHK001,CHK002,CHK003,SKR005,SKR007,SKR010,SKR013,SKR022,SKR030,SKR038,SKR039'
central='GUA001,GUA002,GUA003,FRZ001,FRZ002,FRZ003,FRZ004,FRZ005,FRZ006,FRZ007,FRZ009'
southern='ERR12892801,ERR12892802,LID_1074578,LID_1074772,LID_1074773,LID_1074778,LID_1074779,LID_1074781,LID_1074784,LID_1074786,LID_1074787'

vcf='vcf/cen-sou.quality-filtered.autosomes_only.vcf.gz'

for i in "${sampleList[@]}";
do
    singularity run -B /scratch/brscott4/gelada/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
        vcf2smc \
        -d "${i}" "${i}" \
        ${vcf} \
        smcpp_results/cen-sou/joint_fs_no_mask/pop21.sou-"${i}".NC_0376${SLURM_ARRAY_TASK_ID}.1.smc.gz NC_0376${SLURM_ARRAY_TASK_ID}.1 \
        sou:${southern} cen:${central}
done
