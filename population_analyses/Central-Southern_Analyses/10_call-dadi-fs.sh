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
dadi-cli -h

source scripts/_include_options.sh
mkdir -p Central-Southern_dadi-fs/

popfile='data/CEN.SOU.22.popfile.txt'

# dadi-cli GenerateFs \
#     --vcf dadi-vcf-2/${dataset}.CEN.SOU.22.merged.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
#     --pop-info ${popfile} \
#     --pop-ids CEN SOU \
#     --projections 22 22 \
#     --output dadi_results/${dataset}.CEN.SOU.autosomes.noncoding.folded.fs

dadi-cli GenerateFs \
    --vcf dadi-vcf-2/${dataset}.CEN.SOU.22.merged.autosomes_only.rm_repeats.rm_exons_10k_extended.vcf.gz \
    --pop-info ${popfile} \
    --pop-ids CEN SOU \
    --projections 22 22 \
    --output dadi_results/${dataset}.CEN.SOU.autosomes.noncoding.lowpass.folded.fs \
    --calc-coverage
