#!/bin/bash

chr=$1
dl=$2
vcf=$3
int=$4
northern=$5

singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
    vcf2smc \
    --mask smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.nothern.complement.bed.gz \
    -d "${dl}" "${dl}" \
    ${vcf} \
    smcpp_bootstrap/northern_smcformat/nor-"${dl}".${chr}.iter-${int}.20-sample.smc.gz \
    ${chr} \
    nor:${northern}

# if [ $(zcat smcpp_bootstrap/northern_smcformat/nor-"${dl}".${chr}.iter-${int}.20-sample.smc.gz | wc -l ) -lt 2 ]; then
#     singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
#         vcf2smc \
#         --mask smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.nothern.complement.bed.gz \
#         -d "${dl}" "${dl}" \
#         ${vcf} \
#         smcpp_bootstrap/northern_smcformat/nor-"${dl}".${chr}.iter-${int}.20-sample.redo.smc.gz \
#         ${chr} \
#         nor:${northern}
# fi

# while [ $(zcat smcpp_bootstrap/northern_smcformat/nor-"${dl}".${chr}.iter-${int}.20-sample.smc.gz | wc -l ) -lt 2 ]; do
#     singularity run -B /scratch/brscott4/gelada-chromosome-evolution/ /scratch/brscott4/gelada/smcpp/docker_smcpp.sif \
#         vcf2smc \
#         --mask smcpp_bootstrap/dadi.tgel1.bootstrap.whole_genome.pas_nofilter.nothern.complement.bed.gz \
#         -d "${dl}" "${dl}" \
#         ${vcf} \
#         smcpp_bootstrap/northern_smcformat/nor-"${dl}".${chr}.iter-${int}.20-sample.smc.gz \
#         ${chr} \
#         nor:${northern}
# done
