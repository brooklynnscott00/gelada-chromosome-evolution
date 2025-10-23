#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="vcf2smc central population"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --array=1

mkdir -p smcpp_bootstrap
mkdir -p smcpp_bootstrap/central_smcformat
mkdir -p smcpp_bootstrap/central_samplelist

module load parallel-20220522-gcc-12.1.0
module load bcftools-1.14-gcc-11.2.0
module load htslib-1.21-gcc-11.2.0

int=$(printf %04d $SLURM_ARRAY_TASK_ID)
num_samples=20

#central_all=$(grep -E 'Central|Zoo' data/gelada-metadata.txt | grep -vE 'FRZ003|FRZ008|FRZ015' | cut -f1)
#central=$(printf "%s\n" "${central_all[@]}" | shuf -n $num_samples | paste -sd "," -)

#echo "$central" > smcpp_bootstrap/central_samplelist/central.${int}.txt

if [ "$SLURM_JOB_CPUS_PER_NODE" -eq 1 ]; then
  bcftools filter -S . -e 'FMT/DP=0' -Ou DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter.vcf.gz | bcftools +fill-tags -Ou -- -t AN,AC,AF | bcftools view -Oz -o DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter.fixed.vcf.gz

  bcftools index DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter.fixed.vcf.gz
fi

vcf=DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter.fixed.vcf.gz
samplelist=$(cat smcpp_bootstrap/central_samplelist/central.${int}.txt)
IFS=',' read -r -a dl <<< "$samplelist"

slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)
# IFS=',' read -r -a dl <<< "$northern"
chr=$(cut -f1 data/tgel1_autosomes.bed)

parallel -j $slots scripts/smcpp-bootstrap-central-single.sh {1} {2} {3} {4} {5} ::: $chr ::: ${dl[@]} ::: $vcf ::: $int ::: $samplelist
