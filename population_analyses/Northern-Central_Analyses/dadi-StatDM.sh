#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="dadi statDM"
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
mkdir -p Northern-Central_dadi-stats/

popfile='data/NOR.CEN.22.popfile.txt'

dadi-cli StatDM --fs Northern-Central_dadi-fs/dadi.NOR.CEN.autosomes.noncoding.folded.fs \
	--model IM \
	--grids 60 80 100 \
	--demo-popt Northern-Central_dadi-results/dadi.NOR.CEN.autosomes.noncoding.IM.demo.params.InferDM.bestfits \
	--bootstrapping-dir Northern-Central_dadi-fs/bootstrapping/ \
	--output Northern-Central_dadi-stats/dadi.stats.NOR.CEN.autosomes.noncoding.IM.bestfit.demog.params.ci
