#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="rmrep"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00

# define region, chromosome, and i so we can keep the regions in the proper order
this_region=$(cut -f 1 data/sample_region_list_final.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p) 
chr=$(echo $this_region | cut -d : -f 1) # extracts chromosome ID
i=$(printf '%04d\n' ${SLURM_ARRAY_TASK_ID}) # prints the slurm array task ID as a 4 digit number and assigns it to i

module purge
module load mamba/latest
source activate pandas

mkdir -p beagle_bed

which python3
module list

scripts/beagle-to-bed.py angsd_noheader-glo/angsd-glo_genolike_region_${chr}.${i}.beagle.gz beagle_bed/angsd_noheader-glo_genolike_region_${chr}.${i}.beagle.bed
# scripts/beagle-to-bed.py angsd_noheader-nor/angsd-nor_genolike_region_${chr}.${i}.beagle.gz beagle_bed/angsd_noheader-nor_genolike_region_${chr}.${i}.beagle.bed
# scripts/beagle-to-bed.py angsd_noheader-cen/angsd-cen_genolike_region_${chr}.${i}.beagle.gz beagle_bed/angsd_noheader-cen_genolike_region_${chr}.${i}.beagle.bed
# scripts/beagle-to-bed.py angsd_noheader-sou/angsd-sou_genolike_region_${chr}.${i}.beagle.gz beagle_bed/angsd_noheader-sou_genolike_region_${chr}.${i}.beagle.bed

echo "beagle-to-bed done"
source deactivate
module purge
module load bedtools2-2.30.0-gcc-11.2.0
mkdir -p beagle_bed_rmrep

# subtract repeat regions
bedtools subtract \
	-a beagle_bed/angsd_noheader-glo_genolike_region_${chr}.${i}.beagle.bed \
	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
	beagle_bed_rmrep/angsd_noheader-glo_genolike_region_${chr}_${i}_rmrep.bed

# bedtools subtract \
# 	-a beagle_bed/angsd_noheader-nor_genolike_region_${chr}.${i}.beagle.bed \
# 	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
# 	beagle_bed_rmrep/angsd_noheader-nor_genolike_region_${chr}_${i}_rmrep.bed
# 
# bedtools subtract \
# 	-a beagle_bed/angsd_noheader-cen_genolike_region_${chr}.${i}.beagle.bed \
# 	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
# 	beagle_bed_rmrep/angsd_noheader-cen_genolike_region_${chr}_${i}_rmrep.bed
# 
# bedtools subtract \
# 	-a beagle_bed/angsd_noheader-sou_genolike_region_${chr}.${i}.beagle.bed \
# 	-b /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
# 	beagle_bed_rmrep/angsd_noheader-sou_genolike_region_${chr}_${i}_rmrep.bed

echo "bedtools subtract done"

# custom python script to convert bed file into a beagle file
module purge
module load mamba/latest
source activate pandas

mkdir -p rmrep-glo
mkdir -p rmrep-nor
mkdir -p rmrep-cen
mkdir -p rmrep-sou

scripts/bed-to-beagle.py beagle_bed_rmrep/angsd_noheader-glo_genolike_region_${chr}_${i}_rmrep.bed angsd_noheader-glo/angsd-glo_genolike_region_${chr}.${i}.beagle.gz rmrep-glo/angsd_noheader-glo_genolike_region_${chr}_${i}_rmrep.beagle.gz
# scripts/bed-to-beagle.py beagle_bed_rmrep/angsd_noheader-nor_genolike_region_${chr}_${i}_rmrep.bed angsd_noheader-nor/angsd-nor_genolike_region_${chr}.${i}.beagle.gz rmrep-nor/angsd_noheader-nor_genolike_region_${chr}_${i}_rmrep.beagle.gz
# scripts/bed-to-beagle.py beagle_bed_rmrep/angsd_noheader-cen_genolike_region_${chr}_${i}_rmrep.bed angsd_noheader-cen/angsd-cen_genolike_region_${chr}.${i}.beagle.gz rmrep-cen/angsd_noheader-cen_genolike_region_${chr}_${i}_rmrep.beagle.gz
# scripts/bed-to-beagle.py beagle_bed_rmrep/angsd_noheader-sou_genolike_region_${chr}_${i}_rmrep.bed angsd_noheader-sou/angsd-sou_genolike_region_${chr}.${i}.beagle.gz rmrep-sou/angsd_noheader-sou_genolike_region_${chr}_${i}_rmrep.beagle.gz

echo "bed-to-beagle done"
