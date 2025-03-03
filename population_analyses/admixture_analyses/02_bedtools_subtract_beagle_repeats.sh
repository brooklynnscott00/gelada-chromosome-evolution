#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="rmrep"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00

# define region, chromosome, and i so we can keep the regions in the proper order
this_region=$(cut -f 1 /scratch/brscott4/gelada/data/sample_region_list_nobaboons.txt | uniq | sed -n ${SLURM_ARRAY_TASK_ID}p) # extracts chromsome ID and region specific coordinates
chr=$(echo $this_region | cut -d : -f 1) # extracts chromosome ID
i=$(printf '%04d\n' ${SLURM_ARRAY_TASK_ID}) # prints the slurm array task ID as a 4 digit number and assigns it to i

module load mamba/latest

# custom python script to convert beagle file into a bed file
scripts/beagle-to-bed.py angsd/angsd_genolike_region_${chr}.${i}.beagle.gz beagle_bed/angsd_genolike_region_${chr}.${i}.beagle.bed

module purge
module load bedtools2-2.30.0-gcc-11.2.0

mkdir -p beagle_bed_rmrep

# subtract repeat regions
bedtools subtract \
	-a beagle_bed/angsd_genolike_region_${chr}_${i}.bed \
	-b genomes/Theropithecus_gelada.Tgel_1.0.dna_rm_reindexed_refseq.bed > \
	beagle_bed_rmrep/angsd_genolike_region_${chr}_${i}_rmrep.bed

module purge
module load mamba/latest

# custom python script to convert bed file into a beagle file
mkdir -p rmrep
scripts/bed-to-beagle.py beagle_bed_rmrep/angsd_genolike_region_${chr}_${i}_rmrep.bed angsd_single/angsd_genolike_region_${chr}_${i}.beagle.gz rmrep/angsd_genolike_region_${chr}_${i}_rmrep.beagle.gz

