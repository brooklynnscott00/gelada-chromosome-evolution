## Scripts to run admixture analyses with NGSadmix

#### Files to prepare:

`sample_region_list_nobaboons.txt` This is per sample genomic region list that specifies genomic regions assinged to individual samples in the dataset, along with their corresponding bam files. In this case our genome is broken into a total of 947 regions.

```
$ head sample_region_list_nobaboons.txt
NC_037668.1:1-3000000	CHK001	/path/to/bam/
NC_037668.1:1-3000000	CHK002	/path/to/bam/
NC_037668.1:1-3000000	CHK003	/path/to/bam/
NC_037668.1:1-3000000	CHK004	/path/to/bam/
NC_037668.1:1-3000000	CHK005	/path/to/bam/
NC_037668.1:1-3000000	FRZ000	/path/to/bam/
NC_037668.1:1-3000000	FRZ001	/path/to/bam/
NC_037668.1:1-3000000	FRZ002	/path/to/bam/
NC_037668.1:1-3000000	FRZ003	/path/to/bam/
NC_037668.1:1-3000000	FRZ004	/path/to/bam/

```

#### Analysis pipeline

```
sbatch --array=76-947 01_call-angsd.sh```
cat data/angsd_noheader/*NC_037668.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037668.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037669.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037669.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037670.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037670.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037671.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037671.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037672.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037672.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037673.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037673.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037674.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037674.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037675.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037675.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037676.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037676.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037677.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037677.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037678.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037678.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037679.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037679.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037680.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037680.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037680.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037680.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037681.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037681.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037682.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037682.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037683.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037683.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037684.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037684.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037685.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037685.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037686.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037686.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037687.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037687.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037688.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037688.1.full_chr.beagle.gz
cat data/angsd_noheader/*NC_037689.1*beagle.gz > data/angsd_noheader/angsd_genolike_NC_037689.1.full_chr.beagle.gz

```


