#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --mail-user=klchiou@asu.edu
#SBATCH --job-name="thin"
#SBATCH --output=out/slurm-%A_%a.out
#SBATCH --error=out/slurm-%A_%a.err
#SBATCH --partition=htc
#SBATCH --qos=public
#SBATCH --time=4:00:00

# extract chromosome IDs
chr=$(cut -f 1 /scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.dna.toplevel_reindexed_refseq.fa.fai | head -n22 | sed -n ${SLURM_ARRAY_TASK_ID}p)

# if nothing is specified use 10000 
if [ -z "$1" ]; then prune_dist=10000; else prune_dist=$1; fi

module load mamba/latest
source activate pandas

mkdir -p angsd_thinned-glo

# custon python script that ensures there are at least 10000bps between each snp
python scripts/thin-variants.py angsd_chr-glo/angsd_genolike_${chr}.beagle.gz $prune_dist angsd_thinned-glo/angsd-glo_genolike_${chr}_thinned.beagle.gz

