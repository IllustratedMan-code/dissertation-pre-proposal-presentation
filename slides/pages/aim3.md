## Aim 3: A detailed understanding of the effect of HPV viral transcriptional regulators on human gene regulation

- Background
- What we've done so far
- Ideas for the future?

---

# What is HPV?

- Human Papilloma Virus is a double stranded DNA virus
- HPV genome is transported into the nucleus, where it takes advantage of the host's gene regulatory mechanisms to replicate
- Some HPV variants causes cancer and other symptoms

<img v-drag="[567,246,260,269]" src="/HPV-16-genome.png" />

---

# Differences in strain

- There are many different strains of HPV
- "High risk" strains cause cancer, particularly cervical cancer (HPV 16, HPV 18)

---

# The suspects (vTRs)

- E2, E6, and E7 proteins are translated from integrated sections of the HPV genome
- E6 is implicated in the degredation of p53 via binding with the E3-ligase E6AP<sup>1</sup>
- E7 acts as a transcriptional regulator, with "promiscuous binding abilities" and drives the transition into S phase
- E2 controls the transcription of E6 and E7, both through activation and repression, altering chromatin state

<SlidevVideo v-drag="[663,213,294,294]" loop autoplay>

<source src="/e-proteins/E6/e6.webm"/>

</SlidevVideo>

<div v-drag="[751,435,230,56]">

E6 apo crystallization

</div>

<div v-drag="[57,354,658,40]" class="text-sm">
<p>1: Wang, J.C.K., Baddock, H.T., Mafi, A. et al. Structure of the p53 degradation complex from HPV16. Nat Commun 15, 1842 (2024). https://doi.org/10.1038/s41467-024-45920-w </p>

<p>
2: Songock WK, Kim SM, Bodily JM. The human papillomavirus E7 oncoprotein as a regulator of transcription. Virus Res. 2017 Mar 2;231:56-75. doi: 10.1016/j.virusres.2016.10.017. Epub 2016 Nov 8. PMID: 27818212; PMCID: PMC5325776.
</p>

</div>

---

```yaml
layout: image-right
image: hpv-table.svg
```

# The data

- Two low risk strains (HPV6a, HPV11)
- Two high risk strains (HPV16, HPV18)
- 3 vTRs (E2, E6, E7)
- 2 Cell types (Flp-In HEK 293, Flp-In TREx HCT116)
- ATAC-seq, ChIP-seq and RNA-seq

---

```yaml
layout: two-cols
```

# Some exploration

- DEGs show clustering over strain
- [Fullscreen](/hpv-explore.pdf)

::right::

<embed src= "/hpv-explore.pdf" width= "500" height= "500" type="application/pdf">
