setwd("/scratch/brscott4/gelada-chromosome-evolution/")

chromosome_bed=read.table("data/tgel1_autosomes.bed", header = FALSE)
colnames(chromosome_bed) = c("chromosome", "start", "end")

cov_files = list.files("stats/samtools-coverage/", pattern = "\\.cov$")
depth_files = list.files("stats/mosdepth-out/", pattern = "^[A-Z0-9_]*\\.mosdepth\\.summary\\.txt$")

metadata = read.delim("data/gelada-metadata.txt", header = TRUE)

cov_results = data.frame(Sample = character(), MeanCoverage = numeric(), MeanDepth = numeric())

for (file in cov_files) {
  lines = readLines(file.path("stats/samtools-coverage", file), n = 22)
  lines = lines[!grepl("^#", lines)]
  df = read.table(text = lines, header = FALSE, sep = "\t", stringsAsFactors = FALSE)
  
  id = sub("\\.cov$", "", file)
  
  depths = read.delim(file.path("stats/mosdepth-out", paste0(id, ".mosdepth.summary.txt")))
  depths = head(depths, 21)
  
  coverage = as.numeric(df[[6]])
  sizes = as.numeric(df[[3]])
  depth = depths$mean
  
  cov_results = rbind(cov_results, data.frame(
    Sample = sub("\\.cov$", "", file),
    MeanCoverage = sum(coverage*sizes)/sum(sizes),
    MeanDepth = sum(depth*sizes)/sum(sizes)
  ))
}

stats_final = merge(cov_results, metadata, by.x="Sample", by.y="sample_id")
stats_final$population = factor(stats_final$population, levels = c("North", "Central", "Zoo", "South"))

stats_final = stats_final[order(stats_final$population,stats_final$site,stats_final$Sample),]

write.csv(stats_final, "data/library_coverage_depth.csv", row.names = FALSE)
