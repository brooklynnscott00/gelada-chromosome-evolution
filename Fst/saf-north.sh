#!/bin/sh
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=brscott4@asu.edu
#SBATCH --job-name="Fst north"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00
#SBATCH --mem=24G
#SBATCH --cpus-per-task=12

export PATH=$PATH:~/programs/angsd/
module load htslib-1.21-gcc-11.2.0
source scripts/_include_options.sh

# assign chromosome number to slurm array ask ID
chromosomes="
NC_037668.1,NC_037669.1,NC_037670.1,NC_037671.1,\
NC_037672.1,NC_037673.1,NC_037674.1,NC_037675.1,\
NC_037676.1,NC_037677.1,NC_037678.1,NC_037679.1,\
NC_037680.1,NC_037681.1,NC_037682.1,NC_037683.1,\
NC_037684.1,NC_037685.1,NC_037686.1,NC_037687.1,\
NC_037688.1,NC_037689.1
"
chromosome=$(echo "$chromosomes" | cut -d',' -f${SLURM_ARRAY_TASK_ID})

# extract correspinding sample ID 
population="northern central southern"

slots=12

parallel -j $slots scripts/angsd-saf-single.sh {1} {2} ::: $population ::: $chromosome

