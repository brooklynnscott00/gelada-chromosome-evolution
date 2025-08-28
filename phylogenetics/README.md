# This directory contains scripts to run phylogenetic analysis with RaxML

ERR12892802 = 30x coverage
ERR12892801 = 12x coverage 

GUA003 = 30x coverage
GUA002 = 15x coverage 

SKR015 = 30x coverage
CHK001 = 15x coverage

raxml-8.2.12-gcc-12.1.0



bcftools call consensus sequences and filter for autosomes
```shell
$sbatch --array=1-6 phylogenetics/bcftool-consensus.sh

$sbatch --partition=htc --time=2:00:00 --mem=32G --output=out/slurm-%j.out --error=out/slurm-%j.err --wrap "module load samtools-1.21-gcc-12.1.0; module load bcftools-1.14-gcc-11.2.0; bcftools consensus -s FIL017 -f /scratch/brscott4/gelada/data/genome/Tgel_1.0.dna.fa /data/CEM/smacklab/gelada_project/vcf/final/gelada.tgel1.filtered.all.step2.vcf.gz -o RAxML/consensus/FIL017.whole_genome.fasta"

$sbatch --array=1-7 phylogenetics/filter-consensus.sh
```

convert fasta format to phy
```shell
sbatch phylogenetics/fasta-to-phy.sh
sbatch phylogenetics/fasta-to-phy.sh
`sbatch phylogenetics/raxml-WGS-phylogeny.sh
```
