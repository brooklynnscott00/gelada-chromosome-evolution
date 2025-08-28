library(ggplot2)
library(ggbeeswarm)

het=read.table("/scratch/brscott4/gelada-chromosome-evolution/data/het.txt" , header = TRUE, sep="\t")
f=read.table("/scratch/brscott4/gelada-chromosome-evolution/stats/het-100kb_window-10kb_slide.mean", header = TRUE)
metadata=read.table("/scratch/brscott4/gelada-chromosome-evolution/data/gelada-metadata.txt", header = TRUE)
cov=read.table("/scratch/brscott4/gelada-chromosome-evolution/data/coverage.txt", header = FALSE)

names(cov)[1] <- "animal_id"
names(cov)[2] <- "cov"
cov[, 1] <- sub("\\.cov$", "", cov[, 1])
het_final = merge(het,cov, by.x="animal_id")
f_final = merge(f, metadata, by.x="animal_id", by.y="sample_id")

ggplot(het_final[het_final$ancestry == "South", ], aes(x = cov, y = F, color = sample_type)) +
  geom_point() +
  labs(
    x = "coverage",
    y = "inbreeding",
  ) +
  theme_classic(base_size=16)

ggplot(het_final[het_final$ancestry == "South", ], aes(x = cov, y = HET_ADJ, color = sample_type)) +
  geom_point() +
  labs(
    x = "coverage",
    y = "heterozygosity",
  ) +
  theme_classic(base_size=16)


# plot heterozygosity 
p = ggplot(het,aes(ancestry,HET_ADJ*1000,color=population)) + 
  geom_quasirandom() + 
  theme_classic(base_size=16) + 
  coord_cartesian(ylim=c(0,1)) + 
  theme(
    axis.title.x = element_blank(),
    legend.position = "none"
    ) + 
  ylab(expression('Heterozygosity (per '*10^3*' bp)')) +
  scale_color_manual(
    values = c(
      "North" = "#ff7f00",
      "Central" = "#4daf4a",
      "South" = "#984ea3",
      "Zoo" = '#666666'
    )
  )

ggsave("figures/heterozygosity_plot.pdf", plot = p, width = 7, height = 6)

# plot the Fmean
p = ggplot() +
  geom_quasirandom(data = het, aes(x = ancestry, y = F, color = population)) +
  geom_boxplot(data = het, aes(x = ancestry, y = F), color = 'black', width=0.1, outlier.shape = NA) +
  #geom_point(data = subset(het_final, grepl('ERR', animal_id)), aes(x=population,y=F_mean), color = 'black',size = 2, shape = 21) +
  #geom_jitter(width = 0.1, size = 0.25) +
  #coord_cartesian(ylim = c(-0.5,1)) +
  coord_cartesian()
  #scale_y_continuous(trans = 'log2')
  theme_classic()+
  theme(
    legend.position='top',
    legend.text=element_text(size=14)
  ) +
  scale_color_manual(
    values = c(
      "North" = "#ff7f00",
      "Central" = "#4daf4a",
      "South" = "#984ea3",
      "Zoo" = '#666666'
    )
  ) +
  scale_fill_manual(
    values = c(
      "North" = "#ff7f00",
      "Central" = "#4daf4a",
      "South" = "#984ea3",
      "Zoo" = '#666666'
    )
  )
``

p = ggplot(het,aes(ancestry,HET_ADJ*1000,color=sample_type)) + geom_quasirandom() + theme_classic(base_size=16) + coord_cartesian(ylim=c(0,1)) + theme(axis.title.x = element_blank()) + ylab(expression('Heterozygosity (per '*10^3*' bp)'))

ggsave("figures/heterozygosity_plot.pdf", plot = p, width = 7, height = 6)
