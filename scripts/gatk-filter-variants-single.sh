#!/bin/bash

source scripts/_include_options.sh

i=$1
int=$(printf %04d $i)
region=$(sed -n ${i}p data/${genome}_regions.txt)
chr=$(echo $region | cut -d : -f 1)

if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

gatk --java-options "-Xmx4g" VariantFiltration \
	--reference genome/${genome_path} \
	--output  ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz \
	--variant  vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.raw.vcf.gz \
	--filter-name "QD" \
	--filter "QD < 2.0" \
	--filter-name "MQ" \
	--filter "MQ < 40.0" \
	--filter-name "FS" \
	--filter "FS > 60.0" \
	--filter-name "MQRS" \
	--filter "MQRankSum < -12.5" \
	--filter-name "RPRS" \
	--filter "ReadPosRankSum < -8.0" \
	--filter-name "SOR" \
	--filter "SOR > 3.0" \
	--missing-values-evaluate-as-failing

if [ $(bgzip -t ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz.tbi vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz.tbi
fi

rm -rf $tmp_dir

fi

if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

# pas are biallelic
bcftools view -i 'F_MISSING=0' -m2 -M2 -v snps -f .,PASS -Oz -o ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz
tabix -p vcf ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz

if [ $(bgzip -t ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz.tbi vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas.vcf.gz.tbi
fi

rm -rf $tmp_dir

fi

# snv are SNVs 
# includes non biallelic sites
if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

bcftools view -i 'F_MISSING=0' -v snps -f .,PASS -Oz -o ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz
tabix -p vcf ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz

if [ $(bgzip -t ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz
mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz.tbi vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv.vcf.gz.tbi
fi

rm -rf $tmp_dir

fi
