ERR12892802 = 30x coverage
ERR12892801 = 12x coverage 

GUA003 = 30x coverage
GUA002 = 15x coverage 

SKR015 = 30x coverage
CHK001 = 15x coverage

raxml-8.2.12-gcc-12.1.0

# bcftools call consensus sequences 
For the first run through I'm only using chr NC_037668.1

`sbatch --array=1-3 phylogenetics/bcftool-consensus.sh`	jobID: 27593504	**failed**
`sbatch --array=1-3 phylogenetics/bcftool-consensus.sh` jobID: 27593638	**failed**
`sbatch --array=1-3 phylogenetics/bcftool-consensus.sh` jobID: 27594649	**DONE**
`sbatch --array=4-6 phylogenetics/bcftool-consensus.sh`	jobID: 27596586	**DONE**

`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27595765	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27595839	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27595846	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596065	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596140	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596277	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596359	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596423	**failed**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596454	**DONE**
`sbatch phylogenetics/fasta-to-phy.sh`	jobID: 27596623	**DONE**

`sbatch phylogenetics/raxml-WGS-phylogeny.sh`	jobID: 27596483	**failed**
`sbatch phylogenetics/raxml-WGS-phylogeny.sh`	jobID: 27596494	**failed**
`sbatch phylogenetics/raxml-WGS-phylogeny.sh`	jobID: 27596512	**failed**
`sbatch phylogenetics/raxml-WGS-phylogeny.sh`	jobID: 27596541	**failed**
`sbatch phylogenetics/raxml-WGS-phylogeny.sh`	jobID: 27596654
`sbatch phylogenetics/raxml-WGS-phylogeny.sh`
`sbatch phylogenetics/raxml-WGS-phylogeny.sh`