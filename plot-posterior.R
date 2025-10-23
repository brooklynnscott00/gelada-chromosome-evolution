library(reticulate)
np <- import("numpy")
library(ggplot2)

posterior = np$load("/scratch/brscott4/gelada-chromosome-evolution/smcpp_results/nor-cen/posterior/split-estimate.posterior.arrays.npz")
posterior$files

# intervals for TMRCA
hs = as.numeric(posterior$f[["hidden_states"]])

# Get all keys
keys = posterior$files
# Identify gamma / sites pairs
gamma_keys <- grep("smc.gz$", keys, value = TRUE)
site_keys  <- paste0(gamma_keys, "_sites")

# test with first object
gk <- gamma_keys[1]
sk <- site_keys[1]

# test with chromsome 1
# chromosome_id <- "NC_037668.1"
#gamma_keys_chr1 <- grep(chromosome_id, gamma_keys, value = TRUE)
#site_keys_chr1  <- paste0(gamma_keys_chr1, "_sites")

gamma = as.array(posterior$f[[gk]])
sites = as.numeric(posterior$f[[sk]])

df <- as.data.frame(gamma) %>%
  mutate(interval = paste0("[", head(hs, -1), ",", tail(hs, -1), ")")) %>%
  pivot_longer(cols = -interval, names_to = "site_idx", values_to = "prob") %>%
  mutate(
    site_idx = as.integer(gsub("V", "", site_idx)),
    site = sites[site_idx],
    chromosome = gk
  )

df$interval <- factor(df$interval, levels = unique(df$interval))
df_sample <- df %>% sample_n(100)
df_sample$interval <- factor(df_sample$interval, levels = unique(df_sample$interval))

p <- ggplot(df_sample, aes(x = site, y = interval, fill = prob)) +
  geom_raster() +      # use geom_raster for large matrices
  scale_fill_viridis_c() +
  theme_minimal() +
  labs(
    x = "Genomic site",
    y = "TMRCA interval",
    fill = "Posterior P",
    title = paste("Posterior TMRCA probabilities for", gk)
  )
