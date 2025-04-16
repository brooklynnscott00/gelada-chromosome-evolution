#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="gatk-gen"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=164G
#SBATCH --cpus-per-task=8
#SBATCH --export=NONE

source scripts/_include_options.sh

slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)

int=$(printf %04d $SLURM_ARRAY_TASK_ID)
region=$(sed -n ${SLURM_ARRAY_TASK_ID}p data/${genome}_regions.txt)
chr=$(echo $region | cut -d : -f 1)


module load jdk-12.0.2_10-gcc-12.1.0
module load htslib-1.21-gcc-11.2.0

skip=0

mkdir -p vcf-split

if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz ]; then
mkdir -p db
rm -rf db/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}
java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar \
    GenomicsDBImport \
    --intervals ${region} \
    $(ls /data/CEM/smacklab/gelada_project/gvcf/tgel1/*.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz | sed 's/^/--variant /g') \
    --batch-size 50 \
    --tmp-dir /tmp \
    --reader-threads $slots \
    --genomicsdb-workspace-path db/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}

touch vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz

skip=1
fi

if [ $skip -lt 1 ]; then
if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar \
    GenotypeGVCFs \
    --intervals ${region} \
    --reference /scratch/brscott4/gelada/data/genome/${genome_path} \
    --variant gendb://db/${dataset}.${genome}.bootstrap.region.${int}.chr${chr} \
    --output ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz

if [ $(bgzip -t ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz.tbi vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz.tbi
fi
fi
fi

exit
