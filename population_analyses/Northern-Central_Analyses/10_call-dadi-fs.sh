#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="fs-autosomes"
#SBATCH --output=out/slurm-%j.out
#SBATCH --error=out/slurm-%j.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=1:00:00
#SBATCH --mem=4G

module purge
module load mamba/latest
source activate /scratch/nsnyderm/conda_env/dadi-gpu

source scripts/_include_options.sh
mkdir -p Northern-Central_dadi-fs/

popfile='data/NOR.CEN.22.popfile.txt'

dadi-cli GenerateFs \
    --vcf Northern-Central_dadi-vcf/${dataset}.NOR.CEN.22.merged.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
    --pop-info ${popfile} \
    --projections 22 22 \
    --output Northern-Central_dadi-fs/${dataset}.NOR.CEN.autosomes.noncoding.folded.fs
