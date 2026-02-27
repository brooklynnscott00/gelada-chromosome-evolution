# This directory contains scripts used to generate a phyogeny between the three gelada populations

## prepare input data

```shell
$sbatch snp_phylogeny/extract-samples.sh
$sbatch snp_phylogeny/merge-vcfs.sh
$sbatch snp_phylogeny/filter-merged-vcfs.sh
```
Create VCF with individuals used and filter


```shell
$sbatch snp_phylogeny/vcf2phylip.sh
```
convert vcf to phylip format


## Run IQ-TREE

```shell
$sbatch snp_phylogeny/run-iqtree.sh
```
