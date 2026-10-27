# Run this once
install.packages(c("rentrez", "ggplot2"))

library(rentrez)
library(ggplot2)

# Exact values for your assignment
gene_symbol <- "TNNT1"
transcript_accession <- "NM_003283.6"
clinvar_id <- "12440"
variant_protein <- "p.Glu180Ter"

for (x in c("data", "results", "figures")) {
  dir.create(x, showWarnings = FALSE)
}
