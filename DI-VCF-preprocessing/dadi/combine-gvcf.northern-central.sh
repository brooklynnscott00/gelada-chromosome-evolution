#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="combine-gvcfs"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=48:00:00
#SBATCH --mem=32G

source scripts/_include_options.sh
mkdir -p gvcf

north_all=$(grep 'North' data/gelada-metadata.txt | cut -f1)
ls /data/CEM/smacklab/gelada_project/gvcf-all/ | grep -F -f <(echo "$north_all") | grep '\.g.vcf\.gz$' | sed 's|^|/data/CEM/smacklab/gelada_project/gvcf-all/|' > data/north_gvcf_list.txt

central_all=$(grep -E 'Central|Zoo' data/gelada-metadata.txt | grep -vE 'FRZ003|FRZ008|FRZ015' | cut -f1)
ls /data/CEM/smacklab/gelada_project/gvcf-all/ | grep -F -f <(echo "$central_all") | grep '\.g.vcf\.gz$' | sed 's|^|/data/CEM/smacklab/gelada_project/gvcf-all/|' > data/central_gvcf_list.txt

cat data/north_gvcf_list.txt data/central_gvcf_list.txt > /scratch/brscott4/gelada-chromosome-evolution/data/northern_central_gvcf_list.txt

variants=$(awk '{printf "--variant %s ", $0}' /scratch/brscott4/gelada-chromosome-evolution/data/northern_central_gvcf_list.txt)

java -jar ~/gatk-4.2.5.0/gatk-package-4.2.5.0-local.jar CombineGVCFs \
   -R /scratch/brscott4/gelada/data/genome/${genome_path} \
   $variants \
   -O DI-gvcf/northern-96.central-27.cohort.g.vcf.gz

