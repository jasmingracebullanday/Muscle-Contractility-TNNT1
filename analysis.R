# Muscle Contractility Lab – analysis.R
# Assignment: TNNT1


library(rentrez)
library(ggplot2)

# ===== Your assigned values =====
gene_symbol          <- "TNNT1"
transcript_accession <- "NM_003283.6"
clinvar_id           <- "12440"
variant_protein      <- "p.Glu180Ter"

# Create folders
dir.create("data", showWarnings = FALSE)
dir.create("results", showWarnings = FALSE)
dir.create("figures", showWarnings = FALSE)

# Step 2: Get Gene information
hits <- entrez_search(db = "gene",
                      term = paste0(gene_symbol, "[Gene Name] AND txid9606[Organism]"),
                      retmax = 20)

gene_id <- NA
for (id in hits$ids) {
  rec <- entrez_summary(db = "gene", id = id)
  if (toupper(rec$name) == toupper(gene_symbol)) {
    gene_id <- id
    gene_info <- rec
    break
  }
}
if (is.na(gene_id)) stop("Gene not found")

writeLines(c(
  paste("Gene symbol:", gene_info$name),
  paste("NCBI Gene ID:", gene_id),
  paste("Official name:", gene_info$description),
  paste("Chromosome:", gene_info$chromosome)
), "results/gene_summary.txt")

# Step 3: Get protein sequence
gb <- entrez_fetch(db = "nuccore", id = transcript_accession,
                   rettype = "gb", retmode = "text")

protein_accession <- gsub('^/protein_id="|"$', "", 
                          regmatches(gb, regexpr('/protein_id="NP_[0-9]+\\.[0-9]+"', gb)))

protein_fasta <- entrez_fetch(db = "protein", id = protein_accession,
                              rettype = "fasta", retmode = "text")

writeLines(protein_fasta, paste0("data/", gene_symbol, "_protein.fasta"))
writeLines(paste("NP accession:", protein_accession), "results/protein_accession.txt")

# Step 4: Amino-acid composition + Figure 1
seq <- paste(readLines(paste0("data/", gene_symbol, "_protein.fasta"))[-1], collapse = "")
aa  <- strsplit(toupper(seq), "")[[1]]
protein_length <- length(aa)

standard <- unlist(strsplit("ACDEFGHIKLMNPQRSTVWY", ""))
counts   <- table(factor(aa, levels = standard))
df       <- data.frame(AminoAcid = standard, Count = as.integer(counts))

write.csv(df, "results/amino_acid_composition.csv", row.names = FALSE)

cat("Protein length:", protein_length, "amino acids\n")
print(head(df[order(-df$Count), ], 3))

# --- Figure 1: Amino-acid composition ---
fig1 <- ggplot(df, aes(AminoAcid, Count)) +
  geom_col(fill = "grey45") +
  theme_bw() +
  labs(title = paste(gene_symbol, "amino-acid composition"),
       x = "Amino acid", y = "Number of residues")

print(fig1)
ggsave("figures/01_amino_acid_composition.png", fig1, width = 8, height = 5, dpi = 300)

# Step 6: Variant position plot (Figure 2)
pos <- as.integer(regmatches(variant_protein, regexpr("[0-9]+", variant_protein)))

if (!is.na(pos) && pos >= 1 && pos <= protein_length) {
  
  fig2 <- ggplot() +
    geom_segment(aes(x = 1, xend = protein_length, y = 0, yend = 0), linewidth = 2) +
    geom_point(aes(x = pos, y = 0), size = 4, color = "red") +
    annotate("text", x = pos, y = 0.25, label = variant_protein, size = 4) +
    xlim(0, protein_length) + 
    ylim(-0.5, 0.5) +
    theme_void() +
    labs(title = paste(gene_symbol, "reference protein"),
         x = "Amino-acid position") +
    theme(axis.title.x = element_text())
  
  print(fig2)
  ggsave("figures/02_variant_position.png", fig2, width = 8, height = 2.5, dpi = 300)
}

cat("\nDone! Check the data/, results/, and figures/ folders.\n")
