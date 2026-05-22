### Aim 1: Comparison of PU.1 genomic binding across immune cells reveals cell type-specific roles in autoimmune disease

- 260 ChIP-seq datasets in 10 immune cell types
- Cell type peaks were associated with GWAS variants (RELI) to provide disease association
- Identification of potential binding partners for PU.1 (using HOMER)
- Peaks are combined with genotype data to predict effect of variant on binding (MARIO)

---

<img v-drag="[121,15,749,524]" src="/poster.jpg" width=80% />

---

```yaml
layout: image-left
image: pu1-disease.png
```

# PU.1 is involved in autoimmune disease

- Each dataset if overlapped with GWAS variants with RELI
- The association p-value is aggregated using Fisher's method

<img v-drag="[546,323,367,77]" src="/pu1-disease-flow.svg"/>

---

```yaml
layout: image-right
image: pu1-homer-composite.png
```

# PU.1 interacts with other transcription factors

- PU.1 has cell-type specific interactivity with other regulatory elements

<img src="/pu1-homer.png"/>

---

```yaml
layout: image-left
image: Fig_5.svg
```

# Comparison of allele binding scores

- Alphagenome and gkm-SVM show good correlation with MARIO
