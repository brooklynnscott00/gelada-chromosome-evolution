#!/bin/bash

i=$1
j=$2

source scripts/_include_options.sh

int=$(printf %04d $(grep -n '^'${j}'$' data/${genome}_regions.txt | cut -d ':' -f 1))
chr=$(echo $j | cut -d : -f 1)

mkdir -p /data/CEM/smacklab/gelada_project/gvcf

if [ ! -f gvcf/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

# gatk --java-options '-Xmx4g' HaplotypeCaller \
# 	--reference genome/${genome_path} \
# 	--output ${tmp_dir}/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz \
# 	--input /scratch/brscott4/gelada/data/mapped_reads/tgel1/${i}.aligned-${genome}.sorted.mkdups.bam \
# 	--intervals $j --emit-ref-confidence GVCF

java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar HaplotypeCaller \
	--reference /scratch/brscott4/gelada/data/genome/${genome_path} \
	--output ${tmp_dir}/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz \
	--input /data/CEM/smacklab/gelada_project/bam-sorted/tgel1/${i}.aligned-${genome}.sorted.mkdups.bam \
	--intervals $j --emit-ref-confidence GVCF

if [ $(bgzip -t ${tmp_dir}/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz gvcf/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz
mv ${tmp_dir}/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz.tbi gvcf/${i}.${genome}.region.${int}.chr${chr}.raw.g.vcf.gz.tbi
fi

rm -rf $tmp_dir

fi

