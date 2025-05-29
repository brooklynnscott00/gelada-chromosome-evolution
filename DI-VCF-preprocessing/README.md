# Make VCFs for demogrpahic inference analyses

`sbatch --depend=afternotok:25832966 --time=7-00:00:00 DI-VCF-preprocessing/combine-gvcfs.sh`	jobID: 25929071	**DONE**
Combine gvcf files to make a cohort gvcf of all animals who will be used for DI analysis 

`sbatch DI-VCF-preprocessing/filter-gvcf-samples.sh`	jobID: 26032884	**failed**
`sbatch DI-VCF-preprocessing/filter-gvcf-samples.sh`	jobID: 26032897	**timeout**
`sbatch --depend=afternotok:26032897 --array=1-2 DI-VCF-preprocessing/filter-gvcf-samples.sh`	jobID: 26044753	**DONE**
Filter the gvcf to get 2 cohort gvcfs to call variants from 

`sbatch --depend=afterok:26044753 --array=1-2 DI-VCF-preprocessing/call-variants.sh`	jobID: 26044769	**failed**
`sbatch --array=1-2 DI-VCF-preprocessing/call-variants.sh`	jobID: 26331645	**timeout**
`sbatch --time=7-00:00:00 --array=1-2 DI-VCF-preprocessing/call-variants.sh`	jobID: 26390310	**DONE**
Call variants 

`sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh`	jobID: 26450031	**failed**
`sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh`	jobID: 26450037	**failed**
`sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh`	jobID: 26450046	**failed**
`sbatch --array=1-2 DI-VCF-preprocessing/quality-filter-variants.sh`	jobID: 26450064	**DONE**

`filter for autosomes`
`remove repetitive regions`
`remove exons`
