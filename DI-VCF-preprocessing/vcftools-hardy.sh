#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="vcftools hardy weinberg equilibrium"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=general
#SBATCH --qos=public
#SBATCH --time=24:00:00
#SBATCH --mem=32G

module load vcftools-0.1.14-gcc-11.2.0

source scripts/_include_options.sh
mkdir -p DI-vcf

populations='northern,central,southern'
population=$(echo "$populations" | cut -d',' -f${SLURM_ARRAY_TASK_ID})


vcftools --gzvcf DI-vcf/${population}.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz --out DI-vcf/${population}.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.hardy.weir.fst --hardy

awk 'BEGIN{OFS="\t"} $1=="CHR"{next}
{
  split($3,a,"/");
  n = a[1]+a[2]+a[3];
  if(n>0) printf "%s\t%s\t%.6f\n",$1,$2,(a[2]/n);
}' DI-vcf/${population}.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.hardy.weir.fst.hwe \
> DI-vcf/${population}.het_fraction_per_site.tsv

awk '$1=="CHR"{next}
{
  split($3,a,"/");
  n = a[1]+a[2]+a[3];
  if(n>0 && (a[2]/n) >= 0.8) printf "%s\t%s\t%.6f\n",$1,$2,(a[2]/n);
}' DI-vcf/${population}.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.hardy.weir.fst.hwe \
> DI-vcf/${population}.high_het_sites_0.8.tsv

awk '$1=="CHR"{next}
{
  split($3,a,"/");
  n = a[1]+a[2]+a[3];
  if(n>0 && (a[2]/n) >= 0.9) printf "%s\t%s\t%.6f\n",$1,$2,(a[2]/n);
}' DI-vcf/${population}.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.hardy.weir.fst.hwe \
> DI-vcf/${population}.high_het_sites_0.9.tsv

awk '$1=="CHR"{next}
{
  split($3,a,"/");
  n = a[1]+a[2]+a[3];
  if(n>0 && (a[2]/n) >= 1.0) printf "%s\t%s\t%.6f\n",$1,$2,(a[2]/n);
}' DI-vcf/${population}.quality-filtered.autosomes_only.rm_repeats.rm_exons_10k_extended.hardy.weir.fst.hwe \
> DI-vcf/${population}.high_het_sites_1.0.tsv
