#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="ngsadmix"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=0

# load modules
module load mamba/latest

source activate /data/CEM/smacklab/libraries/python/.conda/envs/angsd

K=${SLURM_ARRAY_TASK_ID}

mkdir -p stats/ngsadmix

NGSadmix -likes angsd_final/angsd_genolike_autosomes.beagle.gz -K ${K} -o stats/ngsadmix/gelada_admix_prop.K${K} -minMaf 0.05 -P $SLURM_CPUS_ON_NODE

# # Per chromosome
# mkdir -p angsd_chr;
# for i in `cat data/chromosomes.txt`; do zcat angsd_final/angsd_genolike_autosomes.beagle.gz | grep $i | gzip -c > angsd_chr/angsd_${i}.beagle.gz; done
# 
# zcat angsd_final/angsd_genolike_autosomes.beagle.gz | grep 'NC_037674.1|NC_037675.1' | gzip -c > angsd_chr/angsd_NC_037674.1_NC_037675.1.beagle.gz
# mkdir -p stats/ngsadmix_chr
# for i in `cat data/chromosomes.txt`; do
# NGSadmix -likes angsd_chr/angsd_${i}.beagle.gz -K 2 -o stats/ngsadmix_chr/gelada_admix_prop.${i}.K2 -minMaf 0.05 -P $SLURM_CPUS_ON_NODE
# done

