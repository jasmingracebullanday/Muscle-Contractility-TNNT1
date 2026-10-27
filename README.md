# Muscle-Contractility-TNNT1

**Assignment Number:** 11  
**Gene:** TNNT1  
**Transcript:** NM_003283.6  
**Variant:** c.538G>T (p.Glu180Ter)  
**ClinVar Variation ID:** 12440  
**Date of analysis:** October 28, 2026  

---

## Research Question

How does the nonsense variant NM_003283.6:c.538G>T (p.Glu180Ter) in the human TNNT1 gene affect the structure and function of slow skeletal muscle troponin T, and what are the molecular consequences for muscle contraction?

---

## 1. What does the assigned gene encode, and how does this protein contribute to muscle function?

TNNT1 encodes **troponin T, slow skeletal muscle isoform** (also called slow skeletal troponin T or ssTnT).  

Troponin T is one of the three subunits of the troponin complex (together with troponin C and troponin I) located on the thin filament of the sarcomere. Its primary roles are:

- Binding tropomyosin and anchoring the troponin complex to the thin filament  
- Transmitting the calcium-binding signal from troponin C to the rest of the thin filament  
- Enabling calcium-dependent regulation of actin–myosin interaction in **slow-twitch skeletal muscle fibers**

Without functional slow skeletal troponin T, the thin filament cannot properly respond to calcium, leading to impaired force generation in slow-twitch fibers.

---

## 2. Exact protein accession and length retrieved with R

- **RefSeq protein accession:** NP_003274.3  
- **Protein length:** 278 amino acids  
- **Source transcript:** NM_003283.6 (MANE Select)

This corresponds to the longest isoform (isoform a) of human slow skeletal troponin T.

---

## 3. Amino-acid composition results

The complete amino-acid frequency table is saved in `results/amino_acid_composition.csv`.  
The bar chart is saved as `figures/01_amino_acid_composition.png`.

**Three most abundant amino acids** (from the R analysis):

1. Glutamic acid (E)  
2. Lysine (K)  
3. Alanine (A) / Leucine (L) (depending on exact count)

**Important limitation:**  
Amino-acid composition alone does **not** prove protein function or the effect of a variant. It only describes the overall residue content of the wild-type protein.

---

## 4. Fixed ClinVar variant – current classification and evidence

**Variant:** NM_003283.6(TNNT1):c.538G>T (p.Glu180Ter)  
**ClinVar Variation ID:** 12440  
**Link:** https://www.ncbi.nlm.nih.gov/clinvar/variation/12440/  
**Date accessed:** October 27, 2026  

**Current aggregate classification:** Pathogenic  
**Review status:** Criteria provided, multiple submitters, no conflicts  

**Variant type:** Nonsense (stop-gain)  

This single-nucleotide change creates a premature termination codon at amino acid position 180. Loss-of-function variants in TNNT1 are established as pathogenic for nemaline myopathy type 5 (NEM5).

---

## 5. Scientifically supported mechanism and remaining uncertainty

### Causal chain

TNNT1 gene → slow skeletal troponin T protein → thin-filament regulation in slow-twitch fibers → c.538G>T introduces a premature stop codon (p.Glu180Ter) → truncated or absent protein → defective calcium-regulated contraction → nemaline myopathy.

### What is supported by evidence

- The variant introduces a premature stop codon.  
- Loss-of-function (nonsense, frameshift, and large deletion) variants in TNNT1 cause autosomal recessive nemaline myopathy type 5.  
- Experimental studies on other truncating TNNT1 variants have shown reduced or absent protein and disrupted thin-filament function.

### What remains uncertain

- Whether this specific allele undergoes complete nonsense-mediated mRNA decay (NMD) or produces a stable truncated protein.  
- The precise residual functional activity (if any) of a protein truncated at position 180.  
- Quantitative effects on force generation and calcium sensitivity in human slow-twitch fibers carrying this exact variant.

---

## 6. Additional experiment that would help test the proposed mechanism

A useful experiment would be:

**Force–calcium relationship measurement in patient-derived or CRISPR-edited myotubes** expressing the p.Glu180Ter allele, compared with isogenic controls.  

Alternatively, a reconstituted thin-filament motility assay using purified truncated troponin T (residues 1–179) could directly test whether the truncated protein can still regulate actin–myosin interaction in response to calcium.

---

## Methods (reproducible R workflow)

### Packages
```r
install.packages(c("rentrez", "ggplot2"))
library(rentrez)
library(ggplot2)
