#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="angsd"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G

# load modules
export PATH=$PATH:~/programs/angsd/

# define region, chromosome, and i so we can keep the regions in the proper order
this_region=$(cut -f 1 data/sample_region_list_final.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p) # extracts chromosome ID and region coordinates
chr=$(echo $this_region | cut -d : -f 1) # extracts only the chromosome ID
i=$(printf '%04d\n' ${SLURM_ARRAY_TASK_ID}) # prints the slurm array task ID as a 4 digit number and assigns it to i

mkdir -p data/sample_lists

global='data/sample_region_list_final.txt'

mkdir -p angsd-glo
mkdir -p angsd_noheader-glo

awk '$1 ~ /'${this_region}'/{print}' ${global} | cut -f 2 | sed -E 's:(.*):'$(pwd)'/sample_region_bams//\1_'$(echo $this_region | sed 's/:/./')'.bam:' > data/sample_lists/samples_region_$(echo ${this_region} | sed 's/:/_/').txt

angsd -GL 1 -out angsd-glo/angsd-glo_genolike_region_$(echo ${this_region} | sed 's/:/_/') -nThreads 4 -doGlf 2 -doGeno -4 -doPost 2 -doPlink 2 -doMajorMinor 1 -SNP_pval 1e-6 -doMaf 1 -bam data/sample_lists/samples_region_$(echo ${this_region} | sed 's/:/_/').txt
zcat angsd-glo/angsd-glo_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed 1d | gzip -c > angsd_noheader-glo/angsd-glo_genolike_region_${chr}.${i}.beagle.gz
zcat angsd-glo/angsd-glo_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed -n 1p | gzip -c > angsd_noheader-glo/angsd-glo_genolike_region_${chr}.0000.beagle.gz

# northern='data/northern_sample_region_list_final.txt'
# central='data/central_sample_region_list_final.txt'
# southern='data/southern_sample_region_list_final.txt'
# 
# mkdir -p data/northern_sample_lists/
# mkdir -p data/central_sample_lists/
# mkdir -p data/southern_sample_lists/ 
# 
# # extract sample names for specific region, construct a bam file path for each sample name, and save the path into a new txt file based on region
# # output is a list of bams for a particular region
# awk '$1 ~ /'${this_region}'/{print}' ${northern} | cut -f 2 | sed -E 's:(.*):'$(pwd)'/sample_region_bams//\1_'$(echo $this_region | sed 's/:/./')'.bam:' > data/northern_sample_lists/northern_samples_region_$(echo ${this_region} | sed 's/:/_/').txt
# awk '$1 ~ /'${this_region}'/{print}' ${central} | cut -f 2 | sed -E 's:(.*):'$(pwd)'/sample_region_bams//\1_'$(echo $this_region | sed 's/:/./')'.bam:' > data/central_sample_lists/central_samples_region_$(echo ${this_region} | sed 's/:/_/').txt
# awk '$1 ~ /'${this_region}'/{print}' ${southern} | cut -f 2 | sed -E 's:(.*):'$(pwd)'/sample_region_bams//\1_'$(echo $this_region | sed 's/:/./')'.bam:' > data/southern_sample_lists/southern_samples_region_$(echo ${this_region} | sed 's/:/_/').txt
# 
# mkdir -p angsd-nor
# mkdir -p angsd-cen
# mkdir -p angsd-sou
# 
# mkdir -p angsd_noheader-nor
# mkdir -p angsd_noheader-cen
# mkdir -p angsd_noheader-sou
# 
# # run angsd on list of bams 
# # save output to a region specific file
# angsd -GL 1 -out angsd-nor/angsd-nor_genolike_region_$(echo ${this_region} | sed 's/:/_/') -nThreads 4 -doGlf 2 -doGeno -4 -doPost 2 -doPlink 2 -doMajorMinor 1 -SNP_pval 1e-6 -doMaf 1 -bam data/northern_sample_lists/northern_samples_region_$(echo ${this_region} | sed 's/:/_/').txt
# angsd -GL 1 -out angsd-cen/angsd-cen_genolike_region_$(echo ${this_region} | sed 's/:/_/') -nThreads 4 -doGlf 2 -doGeno -4 -doPost 2 -doPlink 2 -doMajorMinor 1 -SNP_pval 1e-6 -doMaf 1 -bam data/central_sample_lists/central_samples_region_$(echo ${this_region} | sed 's/:/_/').txt
# angsd -GL 1 -out angsd-sou/angsd-sou_genolike_region_$(echo ${this_region} | sed 's/:/_/') -nThreads 4 -doGlf 2 -doGeno -4 -doPost 2 -doPlink 2 -doMajorMinor 1 -SNP_pval 1e-6 -doMaf 1 -bam data/southern_sample_lists/southern_samples_region_$(echo ${this_region} | sed 's/:/_/').txt
# 
# # remove header from output file
# zcat angsd-nor/angsd-nor_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed 1d | gzip -c > angsd_noheader-nor/angsd-nor_genolike_region_${chr}.${i}.beagle.gz
# zcat angsd-cen/angsd-cen_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed 1d | gzip -c > angsd_noheader-cen/angsd-cen_genolike_region_${chr}.${i}.beagle.gz
# zcat angsd-sou/angsd-sou_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed 1d | gzip -c > angsd_noheader-sou/angsd-sou_genolike_region_${chr}.${i}.beagle.gz
# 
# # create a file number 0000 with only the header 
# if [ ${SLURM_ARRAY_TASK_ID} -eq 1 ]; then 
# zcat angsd-nor/angsd-nor_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed -n 1p | gzip -c > angsd_noheader-nor/angsd-nor_genolike_region_${chr}.0000.beagle.gz
# zcat angsd-cen/angsd-cen_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed -n 1p | gzip -c > angsd_noheader-cen/angsd-cen_genolike_region_${chr}.0000.beagle.gz
# zcat angsd-sou/angsd-sou_genolike_region_$(echo ${this_region} | sed 's/:/_/').beagle.gz | sed -n 1p | gzip -c > angsd_noheader-sou/angsd-sou_genolike_region_${chr}.0000.beagle.gz
# fi
# 
