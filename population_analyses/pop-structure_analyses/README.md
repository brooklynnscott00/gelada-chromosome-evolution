# Scripts to run angsd analysis

### Analysis pipeline

##### Step 1
`sbatch --array=1-947 01_call-angsd.sh` run angsd on bam files (947) to get a beagle file output

##### Step 2
`sbatch --array=1-947 --mem=16G 02_bedtools_subtract_beagle_repeats.sh` filter out repetitive regions 

```
mkdir -p angsd_chr
for i in $(cut -f 1 genomes/Theropithecus_gelada.Tgel_1.0.dna.toplevel_reindexed_refseq.fa.fai | head -n22); do
	echo $i; cat rmrep/angsd_genolike_region_${i}_*_rmrep.beagle.gz > angsd_chr/angsd_genolike_${i}.beagle.gz
done
```
##### Step 3
`sbatch --array=1-22 --mem=16G 03_thin_variants.sh 10000` thin variants 10000bps

```
zcat $(ls --color=none angsd_single/*.beagle.gz | head -n1) | head -n1 | gzip -c > angsd_thinned/header.beagle.gz

mkdir -p angsd_final
cat angsd_thinned/header.beagle.gz $(ls --color=none angsd_thinned/angsd_genolike_*_thinned.beagle.gz | grep -v NC_037689.1 | xargs) > angsd_final/angsd_genolike_autosomes.beagle.gz
```

##### Step 4
`sbatch --array=2-5 --mem=64G --cpus-per-task=48 04_run_ngsadmix.sh` run NGSadmix where array numbers are k values

##### Step 5
`sbatch --mem=64G --cpus-per-task=48 05_pcangsd-run.sh` run pcangsd

##### Step 6 
`06_angsd-plot.R` plots the NGSadmix results and pcan
