library(data.table)
library(ggplot2)
library(patchwork)
library(stats)
library(scales)
setwd("/scratch/brscott4/gelada-chromosome-evolution")

# ---------- USER EDIT ----------
fst_file <- "fst_out/fst.autosomes.100kb-window.northern_central.windowed.weir.fst"
piN_file <- "pi_out/pi.autosomes.100kb-window.northern.windowed.pi"
piC_file <- "pi_out/pi.autosomes.100kb-window.central.windowed.pi"

chr7_ids <- c("NC_037674.1","NC_037675.1")
min_snps <- 50
#out_manhattan <- "fst_manhattan_plot.png"
out_grid_png   <- "fst_pi_per_chrom_grid.png"
#out_grid_pdf   <- "fst_pi_per_chrom_grid.pdf"
#outdir <- "asymmetry_results"
#dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
# --------------------------------

# ---------- LOAD & MERGE ----------
fst <- fread(fst_file); setnames(fst, tolower(names(fst)))
pN  <- fread(piN_file); setnames(pN, tolower(names(pN)))
pC  <- fread(piC_file); setnames(pC, tolower(names(pC)))

setnames(fst,
         old = "n_variants",
         new = "n_variants_fst")

setnames(pN,
         old = c("pi", "n_variants"),
         new = c("pi_north", "n_variants_pi_north"))

setnames(pC,
         old = c("pi", "n_variants"),
         new = c("pi_central", "n_variants_pi_central"))

setkeyv(fst, c("chrom","bin_start","bin_end"))
setkeyv(pN, c("chrom","bin_start","bin_end"))
setkeyv(pC, c("chrom","bin_start","bin_end"))

m = merge(fst, pN, all.x = TRUE); m <- merge(m, pC, all.x = TRUE)

# ---------- detect SNP count column & apply min_snps filter ----------
m = m[
  n_variants_fst >= min_snps &
    n_variants_pi_north >= min_snps &
    n_variants_pi_central >= min_snps
]

# ---------- coordinates and numeric ----------
m[, weighted_fst := as.numeric(weighted_fst)]
m[, mean_mb := (((bin_start + bin_end)/2) - 0.5) / 1e6]
m[, start_mb := bin_start/1e6]; m[, end_mb := bin_end/1e6]

# ---------- THRESHOLDS ----------
fst_top <- quantile(m$weighted_fst, 0.99, na.rm = TRUE)
piN_low <- quantile(m$pi_north, 0.01, na.rm = TRUE)
piC_low <- quantile(m$pi_central, 0.01, na.rm = TRUE)

m[, high_fst := weighted_fst >= fst_top]
m[, low_pi_north := pi_north <= piN_low]
m[, low_pi_central := pi_central <= piC_low]

# ---------- PANEL A: Manhattan-like per-chromosome ----------
m[, chrom := factor(chrom, levels = unique(chrom))]
p_manh <- ggplot(m, aes(x = mean_mb, y = weighted_fst, color = high_fst)) +
  geom_point(size = 0.6, alpha = 0.8) +
  scale_color_manual(values = c("TRUE" = "#e31a1c", "FALSE" = "grey70"), labels = c("Top1%","Other"), name = NULL) +
  facet_grid(chrom ~ ., scales = "free_x", space = "free_x") +
  geom_hline(yintercept = fst_top, linetype = "dashed", color = "#e31a1c", size = 0.4) +
  labs(x = "Position (Mb)", y = expression(italic(F)[ST]), title = "Per-chromosome FST (100 kb windows); top 1% highlighted") +
  theme_bw(base_size = 12) +
  theme(panel.grid.minor = element_blank(), strip.text.y = element_text(angle = 0, face = "bold"),
        legend.position = "top", axis.text.x = element_text(size = 7))
ggsave(out_manhattan, p_manh, width = 6.5, height = max(6, 0.4 * length(levels(m$chrom))), dpi = 300)

# ---------- PANEL B: per-chromosome stacked smoothed tracks (all chromosomes) ----------
# make_chr_plot <- function(ch) {
#   # exact per-stat limits you asked for
#   #fixed_limits <- list(FST = c(0.3, 0.9), pi_north = c(0.000, 0.002), pi_central = c(0.000, 0.002))
#   
#   long <- rbind(
#     data.table(stat = "FST",        x = m[chrom_simple == ch]$mean_mb, y = m[chrom_simple == ch]$weighted_fst),
#     data.table(stat = "pi_north",   x = m[chrom_simple == ch]$mean_mb, y = m[chrom_simple == ch]$pi_north),
#     data.table(stat = "pi_central", x = m[chrom_simple == ch]$mean_mb, y = m[chrom_simple == ch]$pi_central)
#   )[is.finite(y)]
#   long[, stat := factor(stat, levels = c("FST", "pi_north", "pi_central"))]
#   
#   rects <- rbindlist(list(
#     data.table(stat = "FST",        xmin = m[chrom_simple == ch]$start_mb[m[chrom_simple == ch]$high_fst],
#                xmax = m[chrom_simple == ch]$end_mb[m[chrom_simple == ch]$high_fst]),
#     data.table(stat = "pi_north",   xmin = m[chrom_simple == ch]$start_mb[m[chrom_simple == ch]$low_pi_north],
#                xmax = m[chrom_simple == ch]$end_mb[m[chrom_simple == ch]$low_pi_north]),
#     data.table(stat = "pi_central", xmin = m[chrom_simple == ch]$start_mb[m[chrom_simple == ch]$low_pi_central],
#                xmax = m[chrom_simple == ch]$end_mb[m[chrom_simple == ch]$low_pi_central])
#   ), use.names = TRUE, fill = TRUE)
#   rects[, stat := factor(stat, levels = c("FST", "pi_north", "pi_central"))]
#   
#   # one row per facet extremum forces identical per-stat limits across chromosomes
#   blank_limits <- rbindlist(list(
#     data.table(stat = "FST"),
#     data.table(stat = "pi_north"),
#     data.table(stat = "pi_central")
#     ))
#   blank_limits[, stat := factor(stat, levels = c("FST", "pi_north", "pi_central"))]
#   
#   ggplot(long, aes(x = x, y = y)) +
#     geom_blank(data = blank_limits, inherit.aes = FALSE, aes(x = x, y = y))
#     #geom_point(shape=21, size=0.2, alpha=0.2, color = "grey80") +
#     geom_rect(data = rects, inherit.aes = FALSE,
#               aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf, fill = stat),
#               alpha = 0.5, color = NA) +
#     #geom_smooth(se = FALSE, span = 0.01, color = "grey30") +
#     facet_grid(stat ~ ., scales = "free_y") +
#     scale_fill_manual(values = c(FST = "#e41a1c", pi_central = "#4daf4a", pi_north = "#ff7f00"), guide = "none") +
#     scale_y_continuous(breaks = pretty_breaks(n = 2)) +
#     scale_x_continuous(n.breaks = 5) +
#     theme_classic() +
#     theme(
#       legend.position = "top",
#       strip.text.y = element_text(angle = 0),
#       strip.background = element_rect(fill = "grey85", color = "black")
#     ) +
#     labs(title = ch, x = "Position (Mb)", y = NULL)
# }
# 
# 

# 
# plots <- Filter(Negate(is.null), lapply(chrom, make_chr_plot))
# 
# # combined grid
# combined <- wrap_plots(plots, ncol =3) & theme(plot.margin = margin(4,4,4,4))
# #ggsave("fst_pi_per_chrom_grid.svg", combined, width = 18, height = 16)
# ggsave(out_grid_png, combined, width = 18, height = 16, dpi = 300)

# add a column with simple chromosome naming scheme
chr_list <- unique(as.character(m$chrom))
chrom = c("chr_1","chr_2","chr_3","chr_4","chr_5","chr_6","chr_7a","chr_7b",
          "chr_8","chr_9","chr_10","chr_11","chr_12","chr_13","chr_14",
          "chr_15","chr_16","chr_17","chr_18","chr_19","Chr_20")
chr_map <- setNames(chrom, chr_list)
m[, chrom_simple := chr_map[chrom]]

# identify regions of high fst and low pi and create data tables with those regions
m[, highfst_lowpi_north := high_fst & low_pi_north]
m[, highfst_lowpi_central := high_fst & low_pi_central]

m[, run_id_north := rleid(highfst_lowpi_north), by = chrom_simple]
m[, run_id_central := rleid(highfst_lowpi_central), by = chrom_simple]

regions_north <- m[highfst_lowpi_north == TRUE,
                   .(region_start = min(start_mb),
                     region_end   = max(end_mb),
                     region_mid   = (min(start_mb) + max(end_mb)) / 2,
                     n_windows    = .N),
                   by = .(chrom_simple, run_id_north)
]
regions_central <- m[highfst_lowpi_central == TRUE,
                     .(region_start = min(start_mb),
                       region_end   = max(end_mb),
                       region_mid   = (min(start_mb) + max(end_mb)) / 2,
                       n_windows    = .N),
                     by = .(chrom_simple, run_id_central)
]
# label the regions so they only plot in the FST facet
regions_north[, stat := factor("FST", levels = c("FST", "pi_north", "pi_central"))]
regions_central[, stat := factor("FST", levels = c("FST", "pi_north", "pi_central"))]

# points + north-intersection vertical bars on FST facet
make_chr_points_north <- function(ch) {
  pts <- rbind(
    data.frame(stat = "FST",       x = m$mean_mb[m$chrom_simple == ch & m$high_fst]),
    data.frame(stat = "pi_north",  x = m$mean_mb[m$chrom_simple == ch & m$low_pi_north])
  )
  pts <- pts[is.finite(pts$x), ]
  if (nrow(pts) == 0) return(NULL)
  pts$y <- 1
  pts$stat <- factor(pts$stat, levels = c("FST", "pi_north"))
  
  # regions for this chromosome (may be zero rows)
  reg <- regions_north[chrom_simple == ch]
  
  # ensure reg has a stat column matching facet variable (so rects only in FST facet)
  if (nrow(reg) > 0 && !"stat" %in% names(reg)) reg$stat <- "FST"
  reg$stat <- factor(reg$stat, levels = c("FST", "pi_north"))
  
  ggplot() +
    # draw region rectangles first (behind points). set fill outside aes() to a literal color
    { if (nrow(reg) > 0) geom_rect(data = reg,
                                   inherit.aes = FALSE,
                                   aes(xmin = region_start, xmax = region_end), 
                                   ymin = -Inf, ymax = Inf,
                                   fill = "#e31a1c", alpha = 0.5, color = "#e31a1c") } +
    geom_point(data = pts, aes(x = x, y = y, color = stat), size = 2, alpha=1) +
    facet_grid(stat ~ ., scales = "free_y") +
    scale_y_continuous(limits = c(0.9, 1.1), expand = c(0, 0)) +
    scale_color_manual(values = c(FST = "black", pi_north = "#fdbf6f"),
                       guide = "none") +
    labs(title = ch, x = "Position (Mb)") +
    theme_classic() +
    theme(
      axis.title.y = element_blank(),
      axis.text.y  = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid   = element_blank(),
      strip.text.y = element_text(angle = 0),
      strip.background = element_rect(fill = "gray90", color = NA),
      plot.title = element_text(hjust = 0.5)
    )
}

plots <- lapply(chrom, make_chr_points_north)
plots <- Filter(Negate(is.null), plots)
combined <- wrap_plots(plotlist = plots, ncol = 3)
ggsave("northern_pi_fst_intersect_grid.png", combined, width = 18, height = 10, dpi = 300)
ggsave("northern_pi_fst_intersect_grid.svg", combined, width = 18, height = 10)

p7a <- make_chr_points_north("chr_7a")
ggsave("northern_pi_fst_intersect_7a.png", p7a, width = 7, height = 2, dpi = 300)
ggsave("northern_pi_fst_intersect_7a.svg", p7a, width = 14, height = 14)

p7b <- make_chr_points_north("chr_7b")
ggsave("northern_pi_fst_intersect_7b.png", p7b, width = 14, height = 2, dpi = 300)
ggsave("northern_pi_fst_intersect_7b.svg", p7b, width = 14, height = 14)


# points + north-central vertical bars on FST facet
make_chr_points_central <- function(ch) {
  pts <- rbind(
    data.frame(stat = "FST",       x = m$mean_mb[m$chrom_simple == ch & m$high_fst]),
    data.frame(stat = "pi_central",  x = m$mean_mb[m$chrom_simple == ch & m$low_pi_central])
  )
  pts <- pts[is.finite(pts$x), ]
  if (nrow(pts) == 0) return(NULL)
  pts$y <- 1
  pts$stat <- factor(pts$stat, levels = c("FST", "pi_central"))
  
  # regions for this chromosome (may be zero rows)
  reg <- regions_central[chrom_simple == ch]
  
  # ensure reg has a stat column matching facet variable (so rects only in FST facet)
  if (nrow(reg) > 0 && !"stat" %in% names(reg)) reg$stat <- "FST"
  reg$stat <- factor(reg$stat, levels = c("FST", "pi_central"))
  
  ggplot() +
    # draw region rectangles first (behind points). set fill outside aes() to a literal color
    { if (nrow(reg) > 0) geom_rect(data = reg,
                                   inherit.aes = FALSE,
                                   aes(xmin = region_start, xmax = region_end), 
                                   ymin = -Inf, ymax = Inf,
                                   fill = "#e31a1c", alpha = 0.5, color = "#e31a1c") } +
    geom_point(data = pts, aes(x = x, y = y, color = stat), size = 2, alpha=1) +
    facet_grid(stat ~ ., scales = "free_y") +
    scale_y_continuous(limits = c(0.9, 1.1), expand = c(0, 0)) +
    scale_color_manual(values = c(FST = "black", pi_central = "#b2df8a"),
                       guide = "none") +
    labs(title = ch, x = "Position (Mb)") +
    theme_classic() +
    theme(
      axis.title.y = element_blank(),
      axis.text.y  = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid   = element_blank(),
      strip.text.y = element_text(angle = 0),
      strip.background = element_rect(fill = "gray90", color = NA),
      plot.title = element_text(hjust = 0.5)
    )
}

plots <- lapply(chrom, make_chr_points_central)
plots <- Filter(Negate(is.null), plots)
combined <- wrap_plots(plotlist = plots, ncol = 3)
ggsave("central_pi_fst_intersect_grid.png", combined, width = 18, height = 10, dpi = 300)
ggsave("central_pi_fst_intersect_grid.svg", combined, width = 18, height = 10)

p7a <- make_chr_points_central("chr_7a")
ggsave("central_pi_fst_intersect_7a.png", p7a, width = 7, height = 3, dpi = 300)
ggsave("central_pi_fst_intersect_7a.svg", p7a, width = 14, height = 14)

p7b <- make_chr_points_central("chr_7b")
ggsave("central_pi_fst_intersect_7b.png", p7b, width = 7, height = 3, dpi = 300)
ggsave("central_pi_fst_intersect_7b.svg", p7b, width = 14, height = 14)



#make_chr_rects <- function(ch) {
#  rects <- rbind(
#    data.frame(stat = "FST",
#               xmin = m$start_mb[m$chrom_simple == ch & m$high_fst],
#               xmax = m$end_mb[m$chrom_simple == ch & m$high_fst]),
#    data.frame(stat = "pi_north",
#               xmin = m$start_mb[m$chrom_simple == ch & m$low_pi_north],
#               xmax = m$end_mb[m$chrom_simple == ch & m$low_pi_north]),
#    data.frame(stat = "pi_central",
#               xmin = m$start_mb[m$chrom_simple == ch & m$low_pi_central],
#               xmax = m$end_mb[m$chrom_simple == ch & m$low_pi_central])
#  )
#  rects <- rects[is.finite(rects$xmin) & is.finite(rects$xmax), ]
#  if (nrow(rects) == 0) return(NULL)
#  
#  rects$ymin <- 0
#  rects$ymax <- 1
#  rects$stat  <- factor(rects$stat, levels = c("FST", "pi_north", "pi_central"))
#  
#  ggplot(rects) +
#    geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = stat),
#              color = NA, alpha = 0.6) +
#    facet_grid(stat ~ ., scales = "free_y") +
#    scale_y_continuous(limits = c(0,1), expand = c(0,0)) +
#    scale_fill_manual(values = c(FST = "#e41a1c", pi_north = "#ff7f00", pi_central = "#4daf4a"),
#                      guide = "none") +
#    labs(title = ch, x = "Position (Mb)") +
#    theme_classic() +
#    theme(
#      axis.title.y = element_blank(),
#      axis.text.y  = element_blank(),
#      axis.ticks.y = element_blank(),
#      panel.grid   = element_blank(),
#      strip.text.y = element_text(angle = 0),
#      strip.background = element_rect(fill = "grey90", color = NA),
#      plot.title = element_text(hjust = 0.5)
#    )
#}
#
#make_chr_points <- function(ch) {
#  pts <- rbind(
#    data.frame(stat = "FST",
#               x = m$mean_mb[m$chrom_simple == ch & m$high_fst]),
#    data.frame(stat = "pi_north",
#               x = m$mean_mb[m$chrom_simple == ch & m$low_pi_north]),
#    data.frame(stat = "pi_central",
#               x = m$mean_mb[m$chrom_simple == ch & m$low_pi_central])
#  )
#  
#  pts <- pts[is.finite(pts$x), ]
#  if (nrow(pts) == 0) return(NULL)
#  
#  pts$y <- 1   # constant y (meaningless, just to place points)
#  pts$stat <- factor(pts$stat, levels = c("FST", "pi_north", "pi_central"))
#  
#  ggplot(pts, aes(x = x, y = y, color = stat)) +
#    geom_point(size = 1.5) +
#    facet_grid(stat ~ ., scales = "free_y") +
#    scale_y_continuous(limits = c(0.9, 1.1), expand = c(0,0)) +
#    scale_color_manual(values = c(FST = "#e41a1c",
#                                  pi_north = "#ff7f00",
#                                  pi_central = "#4daf4a"),
#                       guide = "none") +
#    labs(title = ch, x = "Position (Mb)") +
#    theme_classic() +
#    theme(
#      axis.title.y = element_blank(),
#      axis.text.y  = element_blank(),
#      axis.ticks.y = element_blank(),
#      panel.grid   = element_blank(),
#      strip.text.y = element_text(angle = 0),
#      strip.background = element_rect(fill = "grey90", color = NA),
#      plot.title = element_text(hjust = 0.5)
#    )
#}



# optional cleanup if you don't want the helper column lingering in m
m[, run_id_north := NULL]











make_chr_points <- function(ch) {
  pts <- rbind(
    data.frame(stat = "FST",       x = m$mean_mb[m$chrom_simple == ch & m$high_fst]),
    data.frame(stat = "pi_north",  x = m$mean_mb[m$chrom_simple == ch & m$low_pi_north]),
    data.frame(stat = "pi_central",x = m$mean_mb[m$chrom_simple == ch & m$low_pi_central])
  )
  pts <- pts[is.finite(pts$x), ]
  if (nrow(pts) == 0) return(NULL)
  pts$y <- 1
  pts$stat <- factor(pts$stat, levels = c("FST", "pi_north", "pi_central"))
  
  # regions for this chromosome (may be zero rows)
  reg <- regions_north[chrom_simple == ch]
  
  # ensure reg has a stat column matching facet variable (so rects only in FST facet)
  if (nrow(reg) > 0 && !"stat" %in% names(reg)) reg$stat <- "FST"
  reg$stat <- factor(reg$stat, levels = c("FST", "pi_north", "pi_central"))
  
  ggplot() +
    geom_point(data = pts, aes(x = x, y = y, color = stat), size = 1.5, alpha = 0.5) +
    facet_grid(stat ~ ., scales = "free_y") +
    scale_y_continuous(limits = c(0.9, 1.1), expand = c(0, 0)) +
    scale_color_manual(values = c(FST = "black", pi_north = "#fdbf6f", pi_central = "#b2df8a"),
                       guide = "none") +
    labs(title = ch, x = "Position (Mb)") +
    theme_classic() +
    theme(
      axis.title.y = element_blank(),
      axis.text.y  = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid   = element_blank(),
      strip.text.y = element_text(angle = 0),
      strip.background = element_rect(fill = "gray90", color = NA),
      plot.title = element_text(hjust = 0.5)
    )
}


# produce plots for desired chromosome order (example `chrom` vector)
plots <- lapply(chrom, make_chr_points)
plots <- Filter(Negate(is.null), plots)

# arrange and save (3 columns layout)
combined <- wrap_plots(plotlist = plots, ncol = 3)
ggsave("points_per_chrom.png", combined, width = 18, height = 10, dpi = 300)
ggsave("points_per_chrom.svg", combined, width = 18, height = 10)

p7a <- make_chr_rects("chr_7a")
ggsave("fst_pi_chr_7a.png", p7a, width = 7, height = 3, dpi = 300)
ggsave("fst_pi_chr_7a.svg", p7a, width = 14, height = 14)

p7b <- make_chr_rects("chr_7b")
ggsave("fst_pi_chr_7b.png", p7b, width = 14, height = 3, dpi = 300)
ggsave("fst_pi_chr_7b.svg", p7b, width = 34, height = 14)

# per-chromosome files
for (i in seq_along(plots)) {
  ch <- chr_list[i]
  p <- plots[[i]]
  fname_base <- paste0("fst_pi_", gsub("[^A-Za-z0-9_\\-]", "_", as.character(ch)))
  ggsave(paste0(fname_base, ".png"), p, width = 7, height = 3, dpi=300)
  #ggsave(paste0(fname_base, ".svg"), p, width = 7, height = 4.5)
}

# ---------- binomial enrichment tests ----------
m[, in_chr7 := chrom %in% chr7_ids]

run_binom_grouped <- function(flag, label) {
  trials  <- sum(flag, na.rm = TRUE)                        # total extreme windows genome-wide
  success <- sum(flag & m$in_chr7, na.rm = TRUE)            # how many of those are on chr7
  p_group <- sum(m$in_chr7 & !is.na(flag)) / sum(!is.na(flag))  # expected prob = fraction of genome in chr7
  
  pval <- if (trials > 0) binom.test(success, trials, p = p_group, alternative = "greater")$p.value else NA_real_
  obs   <- if (trials > 0) success / trials else NA_real_
  fold  <- if (!is.na(p_group) && p_group > 0 && trials > 0) obs / p_group else NA_real_
  
  data.table(
    test        = label,
    success     = success,
    trials      = trials,
    expected_pct = sprintf("%.2f%%", 100 * p_group),
    observed_pct = sprintf("%.2f%%", 100 * obs),
    fold_enrich = sprintf("%.2f×", fold),
    p_value     = formatC(pval, format = "e", digits = 2)
  )
}

summary_dt <- rbindlist(list(
  run_binom_grouped(m$high_fst,        "High FST (top 1%)"),
  run_binom_grouped(m$low_pi_north,    "Low pi north (bottom 1%)"),
  run_binom_grouped(m$low_pi_central,  "Low pi central (bottom 1%)")
), use.names = TRUE)

# Print and save
print(summary_dt)

# --- 1) Grouped binomial (conditioning on all overlapping windows) ---
trials_all <- sum(m$high_fst & m$in_chr7)
success_chr7 <- sum(m$highfst_lowpi_north & m$in_chr7, na.rm=TRUE)
p_background = sum(m$overlap)/sum(m$high_fst)
binom.test(success_chr7, trials_all, p = p_background, alternative = "greater")

