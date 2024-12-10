# Demographic history analysis pipeline 

## 

###
# ignore sbatch subset-bams-parallel.sh
# ignore(subset bam files into smaller folders)

VCF

make a combined gvcf for dadi animals

## make vcfs with variant-sites and all-sites
```
sbatch scripts/call-variants.sh
sbatch scripts/call-allsites.sh
```
go back and edit these files with the config file and proper file paths

```
sbatch gatk_variantFiltration.sh
```
go back and edit with the config gile and proper file paths

# remove missing data
# biallelic 

```
module load bcftools-1.14-gcc-11.2.0
bcftools view --apply-filters .,PASS final.quality_filtered.vcf.gz -m2 -M2 --genotype ^miss --include 'TYPE="snp"' --output-type z --output-file final.quality_filtered.pass.biallelic.vcf.gz
```
- Removes all the variants that don't pass quality score and only biallelic sites. go back and change file names etx. to make sure it's all right 

# remove repeats
# remove exons


'''sbatch scripts/bedtools-subtract-repeats.sh'''     jobID: 12179560     **DONE**
- path: /scratch/brscott4/gelada/data/gvcf-dadi-combined/final.quality_filtered.pass.biallelic.rm_repeats.vcf.gz
'''sbatch scripts/bedtools-subtract-exons_10k_extended.sh'''      jobID: 12179791     **DONE**
- path: /scratch/brscott4/gelada/data/gvcf-dadi-combined/final.quality_filtered.pass.biallelic.rm_repeats.rm_exons_10k_extended.vcf.gz




## counting the number of callable sites in the whole genome

'''bcftools view --apply-filters .,PASS final.allsites.nogeno.vcf.gz --genotype ^miss --output-type z --output-file final.allsites.nogeno.filtered.vcf.gz'''
- Filter out missing genotypes from final.allsites.nogeno.vcf.gz , no acutal quality filters because this is a nogenotype vcf file       **DONE**
- path: /scratch/brscott4/gelada/data/gvcf-dadi-combined/final.allsites.nogeno.filtered.vcf.gz

'''sbatch scripts/bedtools-make-low-quality-mask.sh'''    jobID: 12492081    **DONE**
Make a low-quality-mask file from the variants removed during quality filtering
path: /scratch/brscott4/gelada/data/gvcf-dadi-combined/low_quality_mask.vcf

'''zcat final.allsites.nogeno.filtered.vcf.gz |tail -n +15352 |awk '{FS="\t";OFS="\t";print $1,$2-1,$2}' > final.allsites.nogeno.filtered.bed'''
 **DONE** 
'''wc -l final.allsites.nogeno.filtered.bed'''      **DONE**
number of callable sites in the whole genome = 2789600924

(angsd make genotype files)