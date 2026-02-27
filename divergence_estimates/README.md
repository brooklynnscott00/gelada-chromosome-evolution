# This directory contains scripts for windowed estimates of divergence across the genome

```shell
$sbatch divergence_estimates/subset-vcf.sh # jobID 46900633 47103046
$sbatch divergence_estimates/run-vcftools-fst.sh # jobID 46983654 47106179
$sbatch divergence_estimates/run-vcftools-pi.sh # jobID 47290091
```
Run vcftools Fst and pi in sliding windows

`divergence_estimates/fst.R` contains R code for statistical analysis and plotting
