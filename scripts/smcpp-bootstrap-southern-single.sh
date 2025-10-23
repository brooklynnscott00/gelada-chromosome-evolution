#!/bin/bash

chr=$1
dl=$2
vcf=$3
int=$4
southern=$5

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
    vcf2smc \
    --mask smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.southern.complement.bed.gz \
    -d "${dl}" "${dl}" \
    ${vcf} \
    smcpp_bootstrap/southern_smcformat/sou-"${dl}".${chr}.iter-${int}.20-sample.smc.gz \
    ${chr} \
	sou:${southern}
