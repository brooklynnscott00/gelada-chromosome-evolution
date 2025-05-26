# Scripts to run angsd analysis

### Analysis pipeline

```shell
REGION_FILE="data/tgel1_regions.txt"
BAM_DIR="/data/CEM/smacklab/gelada_project/bam-sorted/tgel1/"
OUTPUT="data/sample_region_list.txt"

for BAM in "$BAM_DIR"/*.bam; do
    SAMPLE=$(basename "$BAM" | cut -d'.' -f1) 
    for REGION in $(cat "$REGION_FILE"); do
        echo -e "${REGION}\t${SAMPLE}\t${BAM}" >> "$OUTPUT"
    done
done

sort -k1,1 data/sample_region_list.txt > data/sample_region_list_final.txt
```

`sbatch --array=1-142 population_analyses/pop-structure_analyses/subset-bams-parallel.sh`    jobID: 25756602    **DONE**
`sbatch --partition=general --time=12:00:00 --array=33,35,36,38,39,40,43,44,45,49,61,65,71,72,76,83,95,111,113,114 population_analyses/pop-structure_analyses/subset-bams-parallel.sh`  jobID: 25804032 **DONE**
subset bams into sample regions

##### Step 1
`sbatch --array=1 population_analyses/pop-structure_analyses/01_call-angsd.sh`  jobID: 25804716
`sbatch --array=2-947 population_analyses/pop-structure_analyses/01_call-angsd.sh`  jobID: 25804891 **DONE**
run angsd on bam files (947) to get a beagle file output

`sbatch --array=1 population_analyses/pop-structure_analyses/01_call-angsd.sh`  jobID: 25864433 **DONE**
`sbatch --array=2-947 population_analyses/pop-structure_analyses/01_call-angsd.sh`  jobID: 25864489 **almost DONE**
`sbatch --array=469 --mem=128G population_analyses/pop-structure_analyses/01_call-angsd.sh` jobID: 25876469 **DONE**

##### Step 2
(ready to run)
`sbatch --array=1-947 --mem=16G population_analyses/pop-structure_analyses/02_bedtools_subtract_beagle_repeats.sh`  jobID: 25876587   **failed**
`sbatch --array=1 --mem=16G population_analyses/pop-structure_analyses/02_bedtools_subtract_beagle_repeats.sh`  jobID: 25907106 **DONE**
`sbatch --array=2-947 --mem=16G population_analyses/pop-structure_analyses/02_bedtools_subtract_beagle_repeats.sh`  jobID: 25905270 **DONE**

filter out repetitive regions 

```shell
mkdir -p angsd_chr-glo
for i in $(cut -f 1 /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna.toplevel_reindexed_refseq.fa.fai | head -n22); do
	echo $i; cat rmrep-glo/angsd_noheader-glo_genolike_region_${i}_*_rmrep.beagle.gz > angsd_chr-glo/angsd_genolike_${i}.beagle.gz
done
```
combine angsd files by chromosome 

##### Step 3
`sbatch --array=1-22 --mem=64G population_analyses/pop-structure_analyses/03_thin_variants.sh 10000`    jobID: 25912480 **DONE**
thin variants 10000bps

This is where we add the header back in
```shell
cp angsd_noheader-glo/angsd-glo_genolike_region_NC_037668.1.0000.beagle.gz angsd_thinned-glo/header.beagle.gz
mkdir -p angsd_final-glo
cat angsd_thinned-glo/header.beagle.gz $(ls --color=none angsd_thinned-glo/angsd-glo_genolike_*_thinned.beagle.gz | grep -v NC_037689.1 | xargs) > angsd_final-glo/angsd-glo_genolike_autosomes.beagle.gz
```

##### Step 4
`sbatch --array=2-5 --mem=64G --cpus-per-task=48 population_analyses/pop-structure_analyses/04_run_ngsadmix.sh` jobID: 25913759
run NGSadmix where array numbers are k values

##### Step 5
`sbatch --mem=64G --cpus-per-task=48 population_analyses/pop-structure_analyses/05_pcangsd-run.sh`  jobID: s
run pcangsd

##### Step 6 
`06_angsd-plot.R` plots the NGSadmix results and pcan
