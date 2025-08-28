#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="make consensus sequences"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G

module load samtools-1.21-gcc-12.1.0
module load bcftools-1.14-gcc-11.2.0
source scripts/_include_options.sh

samples="ERR12892802
GUA003
SKR015
CHK001
ERR12892801
GUA002
"
sample=$(echo "$samples" | sed -n "${SLURM_ARRAY_TASK_ID}p")

mkdir -p RAxML/
mkdir -p RAxML/consensus/

samtools faidx /scratch/brscott4/gelada/data/genome/${genome_path} NC_037668.1 | bcftools consensus -s ${sample} vcf-chr/dadi.tgel1.bootstrap.chrNC_037668.1.pas.vcf.gz -o RAxML/consensus/${sample}.fasta