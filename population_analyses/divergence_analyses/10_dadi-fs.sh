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

popfile='data/NOR.CEN.22.popfile.txt'
vcf='/scratch/brscott4/gelada/dadi-cli/data/vcfs/autosomes.quality_filtered.pass.biallelic.rm_repeats.rm_exons_10k_extended.vcf.gz'

dadi-cli GenerateFs \
    --vcf ${vcf} \
    --pop-info ${popfile} \
    --pop-ids NOR CEN \
    --projections 22 22 \
    --output /scratch/brscott4/gelada/dadi-cli/autosomes/autosomes_noncoding.folded.fs
    
