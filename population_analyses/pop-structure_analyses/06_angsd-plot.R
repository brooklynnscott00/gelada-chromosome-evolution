library(tidyverse)
library(RColorBrewer)

gelada.metadata = read.delim('data/gelada_metadata.txt')
gelada.cov = read.table(
	'stats/pcangsd/gelada.cov',
	sep=' ',
	header=FALSE,
	row.names=gelada.metadata$sample_id,
	col.names=gelada.metadata$sample_id) %>% as.matrix

gelada.metadata$site = factor(gelada.metadata$site,levels=c('Sankaber','Gich','Chennek','Zoo','Guassa'))
gelada.metadata$population = factor(gelada.metadata$population,levels=c('North','Zoo','Central'))

gelada.pca = prcomp(gelada.cov)

pca.percentages = format(round(100*(gelada.pca$sdev^2)/sum(gelada.pca$sdev^2),2),scientific=FALSE,digits=2,trim=TRUE)

gelada.pca.plot = data.frame(gelada.metadata,gelada.pca$x)

p = ggplot(gelada.pca.plot,aes(PC1,PC2,color=site)) +
	geom_point(size=2,shape=21) +
	# coord_fixed() +
	theme_classic(base_size=24) +
	scale_color_brewer(name='',palette = 'Dark2') +
	guides(color=guide_legend(override.aes=list(shape=19,size=4))) +
	xlab(paste0('PC1 (',pca.percentages[1],'%)')) +
	ylab(paste0('PC2 (',pca.percentages[2],'%)')) +
	theme(
		axis.ticks=element_blank(),
		axis.text=element_blank(),
		legend.position='top',
		legend.text=element_text(size=14)
	)

dir.create('figures',showWarnings=FALSE)
ggsave(p,file=file.path('figures',paste0('gelada_pcangsd_pca.pdf')),useDingbats=FALSE)


# Read ngsadmix results
output.list = parallel::mclapply(
  2:10,
  function(k) {
    this.table = read.table(paste0('stats/ngsadmix/gelada_admix_prop.K',k,'.qopt'))
    this.table$id = gelada.metadata$sample_id
    this.table.long = reshape2::melt(this.table,id.vars='id')
    this.table.long$k = k
    this.table.long$variable = gsub('V([0-9])',paste0(k,'.\\1'),this.table.long$variable)
    this.table.long
  },
  mc.cores = 4
)

gelada.ancestry = do.call(rbind,output.list)

gelada.ancestry = merge(gelada.ancestry,gelada.metadata,by.x='id',by.y='sample_id')

gelada.ancestry$population = factor(gelada.ancestry$population, level = c('Central','Zoo','North'))
gelada.ancestry$site = factor(gelada.ancestry$site, level = c('Guassa','Zoo','Chennek','Gich','Sankaber'))
gelada.ancestry$id_sorted = factor(gelada.ancestry$id, levels = unique(gelada.ancestry$id[order(gelada.ancestry$population , gelada.ancestry$site)]))

RColorBrewer::brewer.pal(name='Set1',8)

colors = list(
k2  = RColorBrewer::brewer.pal(name='Set1',9)[1:2],
k3  = RColorBrewer::brewer.pal(name='Set1',9)[3:5],
k4  = RColorBrewer::brewer.pal(name='Set1',9)[6:9],
k5  = RColorBrewer::brewer.pal(name='Dark2',5),
k6  = ggpubr::get_palette('aaas',6),
k7  = ggpubr::get_palette('lancet',7),
k8  = ggpubr::get_palette('jco',8),
k9  = ggpubr::get_palette('uchicago',9),
k10 = ggpubr::get_palette('npg',10)
)

color.key = unlist(colors)
names(color.key) = unlist(lapply(colors,function(x) paste0(length(x),'.',1:length(x))))


p = ggplot(droplevels(subset(gelada.ancestry,TRUE)),aes(x = id_sorted, y = value, fill = variable)) +
	geom_bar(stat='identity') +
	facet_grid(rows = vars(k), cols = vars(population), scales = 'free' , space = 'free') +
	scale_y_continuous(breaks=seq(0,1,0.5)) +
	theme_classic() +
	theme(
		axis.title.x = element_blank(),
		axis.text.x = element_blank(),
		axis.ticks.x = element_blank(),
		strip.background = element_blank(),
		legend.position='none',
		strip.text.x.top = element_text(angle=45,hjust=0,vjust=-0.25),
		strip.text.y.right = element_text(angle=0),
		strip.clip = 'off'
	) +
	scale_fill_manual(values=color.key) +
	# scale_fill_brewer(palette = 'Set1') +
	ylab('Ancestry')
ggsave(p,file=file.path('figures',paste0('gelada_ngsadmix_ancestry.pdf')),useDingbats=FALSE)

gelada.ancestry$id_sorted = factor(
	gelada.ancestry$id,
	levels=subset(gelada.ancestry,k==2 & variable=='2.1')$id[order(-subset(gelada.ancestry,k==2 & variable=='2.1')$value)]
)

p = ggplot(droplevels(subset(gelada.ancestry,k==2)),aes(x = id_sorted, y = value, fill = variable)) +
	geom_bar(stat='identity') +
	scale_y_continuous(breaks=seq(0,1,0.5)) +
	facet_grid(rows = NULL, cols = vars(population), scales = 'free' , space = 'free') +
	theme_classic(base_size=24) +
	theme(
		axis.title.x = element_blank(),
		axis.text.x = element_blank(),
		axis.ticks.x = element_blank(),
		axis.line.x = element_blank(),
		axis.line.y =  element_line(linewidth=0.5),
		axis.ticks.y = element_line(linewidth=0.5),
		strip.background = element_blank(),
		legend.position='none',
		strip.text.x.top = element_text(angle=45,hjust=0,vjust=-0.25),
		strip.text.y.right = element_text(angle=0),
		strip.clip = 'off'
	) +
	scale_fill_manual(values=rev(c('#f26522','#00a651'))) +
	# scale_fill_brewer(palette = 'Set1') +
	ylab('Ancestry')
ggsave(p,file=file.path('figures',paste0('gelada_ngsadmix_k2_wholeautosome.pdf')),useDingbats=FALSE,height=3)




# Automatic factoring
gelada.ancestry$variable = factor(gelada.ancestry$variable,levels=unlist(lapply(2:10,function(i) paste0(i,'.',1:i))))
gelada.ancestry$id = factor(gelada.ancestry$id)

split_variable = split(gelada.ancestry,gelada.ancestry$variable)

get_variable_order = function(i,digits=2) {
	if (grepl('^-',i)) {
		reverse=TRUE
		i = gsub('^-','',i)
	} else {
		reverse=FALSE
	}
	out = Reduce(`+`,lapply(
		split_variable[unlist(strsplit(i,'\\+'))],
		function(x) {
			x$value
		}
	))
	if (reverse) {
		if (is.null(digits)) -out else -round(out,digits)
	} else {
		if (is.null(digits)) out else round(out,digits)
	}
}

# Manual factoring
gelada.ancestry$variable = factor(gelada.ancestry$variable,levels=c(
	'2.1','2.2',
	'3.2','3.1','3.3',
	'4.2','4.1','4.3','4.4',
	'5.1','5.5','5.2','5.4','5.3',
	'6.1','6.2','6.3','6.4','6.5','6.6',
	'7.1','7.2','7.3','7.4','7.5','7.6','7.7',
	'8.1','8.2','8.3','8.4','8.5','8.6','8.7','8.8',
	'9.1','9.2','9.3','9.4','9.5','9.6','9.7','9.8','9.9',
	'10.1','10.2','10.3','10.4','10.5','10.6','10.7','10.8','10.9','10.10'
))

gelada.ancestry$id_sorted = factor(
	gelada.ancestry$id,
	levels=levels(gelada.ancestry$id)[do.call(
		order,
		lapply(
			c('-4.2','4.3+4.4','4.4'),
			# c('-5.1','5.2+5.4+5.3','-5.2','-5.4'),
			get_variable_order
		)
	)]
)

p = ggplot(droplevels(subset(gelada.ancestry,TRUE)),aes(x = id_sorted, y = value, fill = variable)) +
	geom_bar(stat='identity') +
	facet_grid(rows = vars(k), cols = vars(site), scales = 'free' , space = 'free') +
	scale_y_continuous(breaks=seq(0,1,0.5)) +
	theme_classic() +
	theme(
		axis.title.x = element_blank(),
		axis.text.x = element_blank(),
		axis.ticks.x = element_blank(),
		strip.background = element_blank(),
		# legend.position='none',
		strip.text.x.top = element_text(angle=45,hjust=0,vjust=-0.25),
		strip.text.y.right = element_text(angle=0),
		strip.clip = 'off'
	) +
	scale_fill_manual(values=color.key) +
	# scale_fill_brewer(palette = 'Set1') +
	ylab('Ancestry')
ggsave(p,file=file.path('figures',paste0('gelada_ngsadmix_ancestry_legend.pdf')),useDingbats=FALSE)



p = ggplot(droplevels(subset(gelada.ancestry,TRUE)),aes(x = id_sorted, y = value, fill = variable)) +
	geom_bar(stat='identity') +
	facet_grid(rows = vars(k), cols = vars(site), scales = 'free' , space = 'free') +
	scale_y_continuous(breaks=seq(0,1,0.5)) +
	theme_classic() +
	theme(
		axis.title.x = element_blank(),
		axis.text.x = element_blank(),
		axis.ticks.x = element_blank(),
		strip.background = element_blank(),
		legend.position='none',
		strip.text.x.top = element_text(angle=45,hjust=0,vjust=-0.25),
		strip.text.y.right = element_text(angle=0),
		strip.clip = 'off'
	) +
	scale_fill_manual(values=color.key) +
	# scale_fill_brewer(palette = 'Set1') +
	ylab('Ancestry')
ggsave(p,file=file.path('figures',paste0('gelada_ngsadmix_ancestry_edited.pdf')),useDingbats=FALSE)



p = ggplot(droplevels(subset(gelada.ancestry,k<=5)),aes(x = id_sorted, y = value, fill = variable)) +
	geom_bar(stat='identity') +
	facet_grid(rows = vars(k), cols = vars(site), scales = 'free' , space = 'free') +
	scale_y_continuous(breaks=seq(0,1,0.5)) +
	theme_classic() +
	theme(
		axis.title.x = element_blank(),
		axis.text.x = element_blank(),
		axis.ticks.x = element_blank(),
		strip.background = element_blank(),
		legend.position='none',
		strip.text.x.top = element_text(angle=45,hjust=0,vjust=-0.25),
		strip.text.y.right = element_text(angle=0),
		strip.clip = 'off'
	) +
	scale_fill_manual(values=color.key) +
	# scale_fill_brewer(palette = 'Set1') +
	ylab('Ancestry')
ggsave(p,file=file.path('figures',paste0('gelada_ngsadmix_ancestry_filtered.pdf')),useDingbats=FALSE,height=4)



chr = scan('data/chromosomes.txt',what='')
files = file.path('stats/ngsadmix_chr',list.files('stats/ngsadmix_chr',pattern='qopt'))

output.list = parallel::mclapply(
  chr,
  function(i) {
    this.table = read.table(file.path('stats/ngsadmix_chr',paste0('gelada_admix_prop.',i,'.K2.qopt')))
    this.table$id = gelada.metadata$sample_id
    this.table$chr = i
    this.table.long = reshape2::melt(this.table,id.vars=c('chr','id'))
    this.table.long$chr = i
    this.table.long
  },
  mc.cores = 4
)

gelada.ancestry2 = do.call(rbind,output.list)

gelada.ancestry2 = merge(gelada.ancestry2,gelada.metadata,by.x='id',by.y='sample_id')

gelada.ancestry2$population = factor(gelada.ancestry2$population, level = c('Central','Zoo','North'))
gelada.ancestry2$site = factor(gelada.ancestry2$site, level = c('Guassa','Zoo','Chennek','Gich','Sankaber'))
gelada.ancestry2$id_sorted = factor(gelada.ancestry2$id, levels = levels(gelada.ancestry$id_sorted))
gelada.ancestry2$chr_sorted = factor(gelada.ancestry2$chr,levels=sort(unique(gelada.ancestry2$chr)),labels=paste0('chr',c(1:6,'7a','7b',8:20)))

levels(gelada.ancestry2$variable) = c(levels(gelada.ancestry2$variable),'V3','V4')

gelada.ancestry2$variable[with(gelada.ancestry2,variable == 'V1' & chr %in% paste0('NC_0376',c(70,72,75,76,79,80,82,84,85,88),'.1'))] = 'V4'
gelada.ancestry2$variable[with(gelada.ancestry2,variable == 'V2' & chr %in% paste0('NC_0376',c(70,72,75,76,79,80,82,84,85,88),'.1'))] = 'V3'

gelada.ancestry2$variable = factor(gelada.ancestry2$variable,levels=paste0('V',1:4),labels=c('V1','V2','V1','V2'))

p = ggplot(droplevels(subset(gelada.ancestry2,TRUE)),aes(x = id_sorted, y = value, fill = variable)) +
	geom_bar(stat='identity') +
	facet_grid(rows = vars(chr_sorted), cols = vars(population), scales = 'free' , space = 'free') +
	scale_y_continuous(breaks=seq(0,1,1)) +
	theme_classic() +
	theme(
		axis.title.x = element_blank(),
		axis.text.x = element_blank(),
		axis.ticks.x = element_blank(),
		strip.background = element_blank(),
		legend.position='none',
		strip.text.x.top = element_text(angle=45,hjust=0,vjust=-0.25),
		strip.text.y.right = element_text(angle=0),
		strip.clip = 'off'
	) +
	scale_fill_manual(values=RColorBrewer::brewer.pal(name='Set1',9)[1:2]) +
	# scale_fill_brewer(palette = 'Set1') +
	ylab('Ancestry')
ggsave(p,file=file.path('figures',paste0('gelada_ngsadmix_chr_ancestry.pdf')),useDingbats=FALSE)

