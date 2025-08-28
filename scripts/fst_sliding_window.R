#!/usr/bin/env Rscript

genome = 'tgel'

# cat GCF_003255815.1_Tgel_1.0_genomic.gff | grep $'\t'gene$'\t' > tgel_genes.gff
# cat GCF_000772875.2_Mmul_8.0.1_genomic.gff | grep $'\t'gene$'\t' > mmul_genes.gff
# cat GCF_000001405.38_GRCh38.p12_genomic.gff | grep $'\t'gene$'\t' > tgel_genes.gff

pop0 = 'northern'
pop1 = 'central'
pop2 = 'southern'

library(tidyr)
library(GenomicRanges)
  

fai = head(read.delim('/scratch/brscott4/gelada/data/genome/Tgel_1.0.dna.1Mb.fa.fai',header=FALSE,stringsAsFactors=FALSE),22)
#chrs = read.delim('genome/tgel_chromosomes.txt',header=FALSE,col.names=c('chr','CHROM'),stringsAsFactors=FALSE)
gtf = read.delim('/scratch/brscott4/gelada/data/genome/Theropithecus_gelada.Tgel_1.0.110_reindexed_refseq_exons.gtf',header=FALSE,col.names=c('CHROM','Var2','Var3','gene.start','gene.end','Var6','Var7','Var8','info'),stringsAsFactors=FALSE)

fst.files = list.files('/scratch/brscott4/gelada-chromosome-evolution/fst_slidingwindow')
  
gene.info = gtf[c('CHROM','gene.start','gene.end','info')]
  
gene.info$chr = gene.info$CHROM
gene.info$id = gsub(' ','',with(gene.info,paste0(chr,':',format(gene.start,scientific=FALSE),'-',format(gene.end,scientific=FALSE))))
gene.info = gene.info[c('id','chr','gene.start','gene.end','info')]
  
pbs = do.call(rbind,lapply(fst.files,function(f) {
    x = read.delim(paste0('/scratch/brscott4/gelada-chromosome-evolution/fst_slidingwindow/',f),stringsAsFactors=FALSE)
    x$window.start = gsub('^\\(([0-9]+),([0-9]+)\\)\\(([0-9]+),([0-9]+)\\)\\(([0-9]+),([0-9]+)\\)$','\\5',x$region) %>% as.integer
    x$window.end = gsub('^\\(([0-9]+),([0-9]+)\\)\\(([0-9]+),([0-9]+)\\)\\(([0-9]+),([0-9]+)\\)$','\\6',x$region) %>% as.integer - 1
    x$id = gsub(' ','',with(x,paste0(chr,':',format(window.start,scientific=FALSE),'-',format(window.end,scientific=FALSE))))
    x = x[c('id','chr','window.start','window.end','region','Nsites','Fst01','Fst02','Fst12','PBS0','PBS1','PBS2')]
    x
  }))

chr.ncbi = unique(pbs$chr)
chr.ensemble = c(1:6, '7a', '7b', 8:20, 'X')
names(chr.ensemble) = chr.ncbi
pbs$chr_name = chr.ensemble[pbs$chr]

ss = pbs

ss$outlier0 = with(ss,PBS0 > mean(PBS0,na.rm=TRUE) + 2 * sd(PBS0,na.rm=TRUE))
ss$outlier1 = with(ss,PBS1 > mean(PBS1,na.rm=TRUE) + 2 * sd(PBS1,na.rm=TRUE))
ss$outlier2 = with(ss,PBS2 > mean(PBS2,na.rm=TRUE) + 2 * sd(PBS2,na.rm=TRUE))

ss$outlier01 = with(ss,Fst01 > mean(Fst01,na.rm=TRUE) + 2 * sd(Fst01,na.rm=TRUE))
#ss$outlier1 = with(ss,PBS1 > mean(PBS1,na.rm=TRUE) + 4 * sd(PBS1,na.rm=TRUE))
#ss$outlier2 = with(ss,PBS2 > mean(PBS2,na.rm=TRUE) + 4 * sd(PBS2,na.rm=TRUE))

chr1 = subset(ss, chr == 'NC_037668.1')
chr7 = subset(ss, chr == 'NC_037674.1' | chr == 'NC_037675.1')

ggplot(chr1, aes(x = window.start, y = Fst01, color = outlier01)) +
  geom_point(alpha = 0.1, size = 0.1) +
  theme_classic()

ggplot(ss, aes(PBS0, fill = outlier0)) +
  geom_histogram() +
  theme_classic()

ggplot(ss, aes(x = window.start, y = Fst01, color = outlier01)) +
  geom_point(alpha = 0.1, size = 0.1) +
  theme_classic() +
  facet_wrap(~chr, ncol = 1, strip.position = 'right') +
  theme(strip.background = element_blank())

with(ss, tapply(outlier0, chr, mean))

ggplot(chr7, aes(x = window.start, y = PBS0, color = outlier0)) +
  geom_point(alpha = 0.1, size = 0.25) +
  theme_classic() +
  facet_wrap(~chr, ncol = 1, strip.position = 'right') +
  theme(strip.background = element_blank())

library(biomaRt)

tgel = useEnsembl(biomart = 'ENSEMBL_MART_ENSEMBL',dataset='tgelada_gene_ensembl', version = 102)

tgel.mart = getBM(
  attributes = c('ensembl_gene_id','chromosome_name','start_position','end_position','strand','external_gene_name','external_gene_source'),
  mart = tgel
)

tgel.genes = subset(tgel.mart,chromosome_name %in% c(1:6,'7a','7b', 8:20, 'X'))

#tgel.genes$chr = paste0('chr',tgel.genes$chromosome_name)
#tgel.genes$chr[tgel.genes$chr %in% 'chrX'] = 'chr23'
#tgel.genes$chr[tgel.genes$chr %in% 'chrY'] = 'chr24'

#tgel.genes$id = gsub(' ','',with(tgel.genes,paste0(chr,':',format(start_position,scientific=FALSE),'-',format(end_position,scientific=FALSE))))

iwindows = with(ss, GRanges(chr_name,IRanges(window.start,window.end,names=id),'*'))
igenes = with(tgel.genes,GRanges(chromosome_name,IRanges(start_position,end_position,names=ensembl_gene_id),'+'))

olaps = nearest(iwindows, igenes)

window.genes = data.frame(ss, subset(tgel.genes[olaps,],select=c('ensembl_gene_id','start_position','end_position','strand','external_gene_name')))

tgel.go = getBM(attributes=c('ensembl_gene_id', 'go_id','name_1006'), filters = 'ensembl_gene_id', values = unique(window.genes$ensembl_gene_id), mart = tgel)

View(listAttributes(tgel))


















ss$outlier[is.na(ss$outlier)] = FALSE
  
rownames(ss) = NULL
  
save(list=c('pbs','lsbl','theta','ss'),file='checkpoints/selection_windows.RData')


library(ggplot2)

p = ggplot(ss,aes(window.start,PBS0,color=outlier)) + geom_point(size=0.1,alpha=0.2) + facet_wrap(~chr,ncol=3,scales='free_x') + theme_classic() + theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.text.y=element_blank(),legend.position = 'none') + scale_color_manual(values=c('black','red')) + ylab('PBS')
ggsave(p,file='figures/pbs_windows.pdf',width=10,height=7)

outlier.codes = c(0,diff(ss$int[ss$outlier]))

out = integer(0)
group = 1
for (i in 1:length(outlier.codes)) {
  if (outlier.codes[i] > 4) group = group + 1
  out = c(out,group)
}

ss$outlier.group = NA
ss$outlier.group[ss$outlier] = out

outlier.max = integer(0)
for (i in 1:max(ss$outlier.group,na.rm=TRUE)) {
  outlier.max = c(outlier.max,ss$int[ss$outlier.group %in% i][which.max(ss$PBS0[ss$outlier.group %in% i])])
}

ss$outlier.max = FALSE
ss$outlier.max[ss$int %in% outlier.max] = TRUE

outlier.windows = subset(ss,!is.na(outlier.group))

outlier.windows.split = split(outlier.windows,outlier.windows$outlier.group)

outlier.windows = do.call(rbind,lapply(outlier.windows.split,function(x) {
  chr = unique(x$chr)
  window.start=min(x$window.start)
  window.end=max(x$window.end)
  Nsites=sum(x$Nsites)
  pbs.max=max(x$PBS0)
  pbs.min=min(x$PBS0)
  pbs.mean=mean(x$PBS0)
  outlier.group=unique(x$outlier.group)
  id=paste0(chr,':',format(window.start,scientific=FALSE),'-',format(window.end,scientific=FALSE))
  data.frame(id,chr,window.start,window.end,Nsites,pbs.max,pbs.min,pbs.mean,outlier.group,stringsAsFactors=FALSE)
}))




p = ggplot(ss,aes(Nsites,PBS0,color=outlier,size=factor(outlier))) + geom_point(shape=21) + scale_size_manual(values=c(0.05,0.5)) + scale_color_manual(values=c('#999999','#ff0000')) + theme_classic() + theme(legend.position='none') + xlab('Sites') + ylab('PBS')

ggsave(p,file='figures/sites_by_pbs.pdf',width=7,height=3)






library(biomaRt)

tgel = useMart(biomart = 'ENSEMBL_MART_ENSEMBL',dataset='tgeliens_gene_ensembl')

tgel.mart = getBM(
  attributes = c('entrezgene','ensembl_gene_id','chromosome_name','start_position','end_position','strand','external_gene_name','external_gene_source'),
  mart = tgel
)

tgel.genes = subset(tgel.mart,chromosome_name %in% c(1:24,'X','Y'))

tgel.genes$chr = paste0('chr',tgel.genes$chromosome_name)
tgel.genes$chr[tgel.genes$chr %in% 'chrX'] = 'chr23'
tgel.genes$chr[tgel.genes$chr %in% 'chrY'] = 'chr24'

tgel.genes$id = gsub(' ','',with(tgel.genes,paste0(chr,':',format(start_position,scientific=FALSE),'-',format(end_position,scientific=FALSE))))


iwindows = with(outlier.windows,GRanges(chr,IRanges(window.start,window.end,names=id),'*'))
igenes = with(tgel.genes,GRanges(chr,IRanges(start_position,end_position,names=id),'+'))

olaps = nearest(iwindows, igenes)

window.genes = data.frame(outlier.windows, subset(tgel.genes[olaps,],select=c('ensembl_gene_id','start_position','end_position','strand','external_gene_name')))

tgel.go = getBM(attributes=c('ensembl_gene_id', 'go_id','name_1006'), filters = 'ensembl_gene_id', values = unique(window.genes$ensembl_gene_id), mart = tgel)
