#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="mafft multi-sequence alignment"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4

module purge
module load mamba/latest
source scripts/_include_options.sh

mkdir -p RAxML/consensus-combined/
mkdir -p RAxML/MSA

sed 's/^>.*/>ERR02_chr1/' RAxML/consensus/ERR12892802.fasta > RAxML/consensus/ERR12892802.header.fasta
sed 's/^>.*/>GUA003_chr1/' RAxML/consensus/GUA003.fasta > RAxML/consensus/GUA003.header.fasta
sed 's/^>.*/>SKR015_chr1/' RAxML/consensus/SKR015.fasta > RAxML/consensus/SKR015.header.fasta

sed 's/^>.*/>CHK01_chr1/' RAxML/consensus/CHK001.fasta > RAxML/consensus/CHK001.header.fasta
sed 's/^>.*/>ERR01_chr1/' RAxML/consensus/ERR12892801.fasta > RAxML/consensus/ERR12892801.header.fasta
sed 's/^>.*/>GUA002_chr1/' RAxML/consensus/GUA002.fasta > RAxML/consensus/GUA002.header.fasta

awk 'FNR==1 && NR!=1 {print ""} {print}' \
	RAxML/consensus/ERR12892802.header.fasta \
	RAxML/consensus/GUA003.header.fasta \
	RAxML/consensus/SKR015.header.fasta \
	RAxML/consensus/CHK001.header.fasta \
	RAxML/consensus/ERR12892801.header.fasta \
	RAxML/consensus/GUA002.header.fasta > RAxML/consensus-combined/combined.fasta

source deactivate seqkit
module purge
module load mamba/latest
source activate seqmagick

seqmagick convert RAxML/consensus-combined/combined.fasta RAxML/combined.phy
