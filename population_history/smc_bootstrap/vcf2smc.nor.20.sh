#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="vcf2smc"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --mem=32G
#SBATCH --cpus-per-task=16
#SBATCH --array=1

mkdir -p smcpp_bootstrap
mkdir -p smcpp_bootstrap/northern_smcformat
mkdir -p smcpp_bootstrap/northern_samplelist

module load parallel-20220522-gcc-12.1.0

int=$(printf %04d $SLURM_ARRAY_TASK_ID)
vcf=DI-vcf/smcpp_bootstrap/dadi.tgel1.bootstrap.autosomes_only.pas_nofilter.vcf.gz
num_samples=20

#north_all=$(grep 'North' data/gelada-metadata.txt | cut -f1)
#northern=$(printf "%s\n" "${north_all[@]}" | shuf -n $num_samples | paste -sd "," -)

#echo "$northern" > smcpp_bootstrap/northern_samplelist/northern.${int}.txt

samplelist=$(cat smcpp_bootstrap/northern_samplelist/northern.${int}.txt)
IFS=',' read -r -a dl <<< "$samplelist"

slots=$(echo $SLURM_JOB_CPUS_PER_NODE | sed 's/[()]//g' | sed 's/x/*/g' | sed 's/,/+/g' | bc)
# IFS=',' read -r -a dl <<< "$northern"
chr=$(cut -f1 data/tgel1_autosomes.bed)

parallel -j $slots scripts/smcpp-bootstrap-northern-single.sh {1} {2} {3} {4} {5} ::: $chr ::: ${dl[@]} ::: $vcf ::: $int ::: $samplelist
