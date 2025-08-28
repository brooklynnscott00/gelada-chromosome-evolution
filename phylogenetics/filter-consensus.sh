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
FIL017
"
sample=$(echo "$samples" | sed -n "${SLURM_ARRAY_TASK_ID}p")

regions="
NC_037668.1 NC_037669.1 NC_037670.1 NC_037671.1 \
NC_037672.1 NC_037673.1 NC_037674.1 NC_037675.1 \
NC_037676.1 NC_037677.1 NC_037678.1 NC_037679.1 \
NC_037680.1 NC_037681.1 NC_037682.1 NC_037683.1 \
NC_037684.1 NC_037685.1 NC_037686.1 NC_037687.1 \
NC_037688.1
"

samtools faidx RAxML/consensus/${sample}.whole_genome.fasta ${regions} > RAxML/consensus/${sample}.autosomes.fasta
