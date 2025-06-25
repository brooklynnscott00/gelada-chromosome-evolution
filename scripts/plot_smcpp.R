
args <- commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
  stop("No input file supplied", call.=FALSE)
}

input_file <- args[1]
output_file <- paste0(tools::file_path_sans_ext(basename(input_file)), "_converted.csv")

# Load the JSON file (e.g. SMC++ split model)
library(jsonlite)
model <- fromJSON(input_file)

# Convert time from generations to years (e.g., 25 years/gen)
gen_time <- 25
model$time_years <- model$time * gen_time

# Save to CSV for further plotting or inspection
write.csv(model, output_file, row.names=FALSE)

cat("Output written to:", output_file, "\n")
