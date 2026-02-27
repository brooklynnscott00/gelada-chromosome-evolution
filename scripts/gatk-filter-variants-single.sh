#!/bin/bash

source scripts/_include_options.sh

chr=$1

if [ ! -f vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar VariantFiltration \
	--reference /data/CEM/smacklab/gelada_project/assemblies/tgel1/Tgel_1.0.dna.fa \
	--output  ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz \
	--variant  vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.raw.vcf.gz \
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

if [ $(bgzip -t ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz && echo 0 || echo 1) -eq 0 ]; then

mv ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz
mv ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz.tbi vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz.tbi
fi

rm -rf $tmp_dir

fi

if [ ! -f vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

# pas are biallelic
bcftools view -i 'F_MISSING=0' -m2 -M2 -v snps -f .,PASS -Oz -o ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz
tabix -p vcf ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz

if [ $(bgzip -t ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz
mv ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz.tbi vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.pas.vcf.gz.tbi
fi

rm -rf $tmp_dir

fi

# snv are SNVs 
# includes non biallelic sites
if [ ! -f vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz.tbi ]; then

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)

bcftools view -i 'F_MISSING=0' -v snps -f .,PASS -Oz -o ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.flt.vcf.gz
tabix -p vcf ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz

if [ $(bgzip -t ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
mv ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz
mv ${tmp_dir}/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz.tbi vcf-chr/dadi.tgel1.bootstrap.chr_${chr}.snv.vcf.gz.tbi
fi

rm -rf $tmp_di
fi

# include biallelic snps that pass quality filters, do not remove missing sites 
#if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz.tbi ]; then
#
#tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
#
#bcftools view -m2 -M2 -v snps -f .,PASS -Oz -o ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz
#tabix -p vcf ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz
#
#if [ $(bgzip -t ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
#mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz
#mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz.tbi vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.pas_nofilter.vcf.gz.tbi
#fi
#
#rm -rf $tmp_dir
#fi
#
## include non biallelic sites, do not remove missting sites
#if [ ! -f vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz.tbi ]; then
#
#tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
#
#bcftools view -v snps -f .,PASS -Oz -o ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.flt.vcf.gz
#tabix -p vcf ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz
#
#if [ $(bgzip -t ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz && echo 0 || echo 1) -eq 0 ]; then
#mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz
#mv ${tmp_dir}/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz.tbi vcf-split/${dataset}.${genome}.bootstrap.region.${int}.chr${chr}.snv_nofilter.vcf.gz.tbi
#fi
#
#rm -rf $tmp_dir
#fi
