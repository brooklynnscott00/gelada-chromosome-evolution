#!/bin/bash

chr=$1
dl=$2
vcf=$3
int=$4
central=$5

#echo $central

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
    vcf2smc \
    --mask smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.central.complement.bed.gz \
    -d "${dl}" "${dl}" \
    ${vcf} \
    smcpp_bootstrap/central_smcformat/cen-"${dl}".${chr}.iter-${int}.20-sample.smc.gz \
    ${chr} \
	cen:${central}
