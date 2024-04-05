
# PANOPLY Reports and Results

Documentation pages for [Analysis Modules](https://github.com/broadinstitute/PANOPLY/wiki/Data-Analysis-Modules) provide details on the output plots, tables and files generated by running the respective modules. Here, we provide a summary of the interactive HTML reports generated by many of the corresponding [Report Modules](https://github.com/broadinstitute/PANOPLY/wiki/Report-Modules), along with some relevant results not included in the reports. The reports and results illustrated here are based on the (Mertins et al) BRCA data used in the tutorial. As the reports are presented and described, we draw parallels to many of the figures in the original manuscript to illustrate the application of these modules in elucidating biology. 

Many of the analysis/report modules are run as part of the `panoply_main` workflow for *each* proteomics data type -- proteome and phosphoproteome for the BRCA tutorial dataset. Some of the analysis/report modules that are specific to a data type (immune analysis for RNA), or require all the multi-omics data types (NMF multi-omics clustering, Blacksheep outlier analysis) are only run in the `panoply_unified_workflow`. This workflow automatically runs `panoply_main` for each proteomics data types along with the additional analysis modules.

---

## Sample QC
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/sample-qc_all-proteome.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/sample-qc_all-phosphoproteome.html)

The sample QC report is aimed at detecting issues with sample quality, and documents the results of:

A) ESTIMATE  (Yoshihara et al) analysis for assessment of tumor purity and stromal/immune content. Box and whisker plots show the distribution of the stromal score, immune score, ESTIMATE score (a combination of stromal and immune scores) and tumor purity derived from RNA data and CNA/protein data mapped to the gene level. From a sample quality perspective, any consistent outliers in any of these scores will need to be carefully evaluated for exclusion from the data set. These plots are generated from scores in the `*-estimate-scores.gct` tables in the `sample-qc` directory and was used in generating **Extended Data Figure 3 (e)** in (Mertins et al) to show that the stromal scores of samples in `Cluster3` were significantly elevated.

|  |  |  | 
|:-:|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/sample-qc-1.png" alt="Sample QC Fig 1" width="250"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/sample-qc-2.png" alt="Sample QC Fig 2" width="300"> | (**C**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/sample-qc-3.png" alt="Sample QC Fig 3" width="300"> |

B) For RNA, CNA and protein data, sample-wise correlations are calculated for each pair of datasets (RNA-protein, CNA-protein and RNA-CNA). These correlations are displayed as a heatmap and can be used to identify sample swaps and mislabeling. For examples, a sample swap is indicated if the highest correlation for a sample is off-diagonal with a symmetric swap for two samples. There are no apparent sample swaps in the BRCA tutorial data.


C) Additionally, the `sample-qc-plots.pdf` file in the results directory includes a fanplot showing co-clustering of RNA and protein expression for samples, based on protein-gene pairs with moderate to high correlation. This plot, as described in **Extended Data Figure 3 (c)** in (Mertins et al), can be used to evaluate how different the RNA and protein aliquots of the sample are--when these are highly similar, most samples have protein and RNA clustering with each other resulting in a ring of alternating dark and light grey.

---

## Normalization
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/norm_all-proteome.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/norm_all-phosphoproteome.html)

When proteomics data is normalized in PANOPLY, the resulting report summarizes distribution of protein/PTM-site abundances (usually log ratio to a common reference) before (A) and after normalization (B). In addition, a line plot of the normalization centering and scaling factors (C) indicates any samples with extreme normalization factors. Samples with extreme normalization factors may need to be inspected and evaluated for exclusion from the dataset.

|  |  |  | 
|:-:|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/norm-1.png" alt="Normalization Fig 1" width="300"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/norm-2.png" alt="Normalization Fig 2" width="250"> | (**C**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/norm-3.png" alt="Normalization Fig 3" width="300"> |

---

## RNA-protein Correlation 
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/rna-corr_all-proteome.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/rna-corr_all-phosphoproteome.html)

RNA-protein correlation report summarizes gene-wise and sample-wise correlation between RNA and protein expression for samples in the dataset. 

|  |  |  | 
|:-:|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/rna-corr-1.png" alt="RNA Corr Fig 1" width="300"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/rna-corr-2.png" alt="RNA Corr Fig 2" width="250"> | (**C**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/rna-corr-3.png" alt="RNA Corr Fig 3" width="300"> |

A) The histogram shows all gene-wise correlations, and highlights correlations that are statistically significant with FDR < 0.05. The median correlation of all genes is shown using a black dotted line. For the BRCA dataset the median correlation is 0.42. This plot mirrors **Figure 2 (b)** in (Zhang et al), and the underlying `proteome-mrna-cor.tsv` table (in the `rna` directory) was used to generate the GSEA enrichment plot **Extended Data Figure 4 (c)** in (Mertins et al). 

B) The correlation rank plot ranks genes by their correlation (shown on the y-axis). The plot can be interactively explored. The top 10 most correlated genes are listed in the report. 

C) The sample-wise correlation plot displays RNA-protein correlation at the sample level, and represents a different presentation of **Figure 2 (a)** in (Zhang et al).

---

## CNA Analysis
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/cna-analysis_all-proteome.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/cna-analysis_all-phosphoproteome.html)

The CNA analysis report summarizes the CNA-RNA and CNA-proteome cis- and trans-correlations as in **Figure 2 (a)** of (Mertins et al) [or Figure 3 (a)/(b) in (Zhang et al)]. Cis-correlations are positive and represented by the red diagonal. Trans-correlations are represented by vertical bands of red/green (positive/negative) pixels. The left panel shows CNA-RNA correlation, with a lot more correlated pairs compared to the CNA-proteome correlation shown on the right panel. The blue histograms on the bottom show the number of significant correlations for each CNA gene, and the black histograms show common counts between CNA-RNA and CNA-proteome correlations (i.e., common counts between the left and right panels).

|  |
|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/cna-corr-1.png" alt="CNA Corr Fig 1" align="center" width=600>|

---

## Association Analysis
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/all-proteome-full-results_proteome_association_rmd.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/all-phosphoproteome-full-results_phosphoproteome_association_rmd.html)

The association analysis module performs marker selection for categorical sample annotations specified in an input `groups` file. For binary annotations like mutation status, the samples projected to pathways using single sample GSEA (ssGSEA) to identify pathways up/down regulated in each sample. Volcano plots (A) and enriched pathway table (B) are included in the report; heatmaps (C) of the statistically significant markers are available in the `association` analysis directory. The figure below illustrates these for TP53 mutation status. In addition, GSEA results on markers ranked by statistical significance are available in the `*-gsea-analysis` subdirectory. 

|  |  |  | 
|:-:|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/association-1.png" alt="Association Fig 1" width="300"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/association-2.png" alt="Association Fig 2" width="250"> | (**C**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/association-3.png" alt="Association Fig 3" width="300"> |

For categorical annotations with more than two groups, multi-class marker selection (summarized in a heatmap in the `association` analysis directory) is followed by ssGSEA projection. One-vs-all volcano plots (D, for PAM50 Basal vs Rest) and enriched pathway tables (E, for PAM50 Basal vs Rest) are generated in the report. In addition a summary of overall pathway enrichment for all group (F) is included in the association analysis report. The figure below illustrates examples from the PAM50 association analysis for the BRCA tutorial dataset.

|  |  |  | 
|:-:|:-:|:-:|
|(**D**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/association-4.png" alt="Association Fig 4" width="300"> | (**E**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/association-5.png" alt="Association Fig 5" width="250"> | (**F**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/association-6.png" alt="Association Fig 6" width="300"> |

All volcano plots and pathway enrichment tables in the report are interactive. Association analysis results are used in **Extended Data Figure 9** and **Figure 3 (c)** in (Mertins et al).

---

## Consensus Clustering 
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/all-proteome_proteome_cons_clust_rmd.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/proteogenomics_analysis/all-phosphoproteome_phosphoproteome_cons_clust_rmd.html)


The consensus clustering report summarizes the results from k-means consensus clustering, in an effort to identify proteome-based sample subgroups. The method identifies the "best" number of clusters based on cophenetic correlation, delta AUC and silhouette score (A). Two of these metrics were used to identify the optimum number of clustering in **Extended Data Figure 6** in (Mertins et al)--silhouette score in **(c)** and delta AUC in **(d)**. The consensus matrix (B) for the best number of clusters (k=3 for the BRCA tutorial dataset) is reported, and corresponds to **Extended Data Figure 6 (b)**, with a heatmap (C) showing markers for each cluster, as in  ** Extended Data Figure 6 (a)**.

|  |  |  | 
|:-:|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/clustering-1.png" alt="Clustering Fig 1" width="250"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/clustering-2.png" alt="Clustering Fig 2" width="300"> | (**C**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/clustering-3.png" alt="Clustering Fig 3" width="300"> |
|(**D**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/clustering-4.png" alt="Clustering Fig 4" width="300"> | (**E**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/clustering-5.png" alt="Clustering Fig 5" width="250"> | |

As described in **Figure 3 (b)** in (Mertins et al), consensus clustering of the proteome identifies 3 clusters---basal-enriched, luminal-enriched and stromal-enriched. The heatmap in (C) shows the PAM50 labels for the samples, along with several other annotations that were included in the input `groups` file to better characterize samples falling into each cluster. In addition, one-vs-all association analysis is initiated on the cluster labels to identify pathways (using GSEA) that are enriched in each of the clusters (D). The consensus clustering report also includes a PCA plot (E) to illustrate the location and separation of the clusters and the assocated samples. Detailed tables with cluster labels, cluster-specific markers and complete GSEA results can be found in the `clustering` directory.

--- 

## NMF Multi-omics Clustering
Full Reports: [Clustering](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/mo-nmf/mo-nmf-report-all.html)/[ssGSEA](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/mo-nmf/report_all.html)

The NMF multi-omics clustering module is a new analysis method not used in (Mertins et al), but consistently used in the more recent CPTAC manuscripts, as illustrated in **Figure 1 (E)** in (Gillette et al). The report provides details concerning the technical aspects of the clustering, along with annotation, over-representation analysis and pathway analysis of the clusters to promote biological insight into the subtypes defined by the clustering. 

|  |  |  | 
|:-:|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/nmf-1.png" alt="NMF Fig 1" width="300"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/nmf-2.png" alt="NMF Fig 2" width="250"> | (**C**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/nmf-3.png" alt="NMF Fig 3" width="300"> |
|(**D**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/nmf-4.png" alt="NMF Fig 4" width="250"> | (**E**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/nmf-5.png" alt="NMF Fig 5" width="250"> | (**F**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/nmf-6.png" alt="NMF Fig 6" width="300"> |

The optimal number of clusters *k* is determined using a combination of the cophenetic and dispersion coefficients. Once the optimal clustering is defined (with 3 clusters for the BRCA tutorial dataset), an annotation heatmap (A) relates the clusters to other sample annotations (mutation status, PAM50 type, etc). Over-representation analysis of these annotations is performed to determine statistically significant characteristics of the clusters (B). A heatmap summarizes cluster-specific features (C) and the data type they originate from. Barcharts summarize the distribution of these features (D) among the omics data types, followed by a table (E) that can be used to interactively inspect and search these multi-omic features driving the subtyping. Finally, in a separate NMF ssGSEA report, pathway enrichment in these subtypes are visualized (F). 

---

## Immune Analysis
[Full Report](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/immune_analysis/all_immune_rmd.html)

The immune analysis module uses ESTIMATE (Yoshihara et al) and xCell (Aran et al) to derive immune and stromal scores, in addition to quantifying immune and stromal cell types present in tumor samples (using xCell). The immune cell types present in the sample are displayed in a heatmap (A), and the scores from the two methods (ESTIMATE and xCell) are compared using scatterplots (B). In addition, the module also infers immune subtype based on a classifier presented by (Thorrson et al), with the subtype assignment saved in `immune-subtype.csv` in the `immune-analysis` directory. Additionally, enrichment of these immune subtypes in the sample annotation groups is assessed using a Fisher test, with results in `immune-subtype-enrichment.csv`. Any statistically significant enrichments are listed in the report and in `immune-subtype-enrichment-pval*.csv`. ESTIMATE and xCell scores are in `estimate-scores.csv` and `xcell-scores.csv`.

|  |  |
|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/immune-1.png" alt="Immune Fig 1" width="400"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/immune-2.png" alt="Immune Fig 2" width="400"> | 

This module is a recent addition that was not used in the (Mertins et al) study. The xCell immune cell type quantification was used to derive immune clusters in **Figure 5 (A)** in (Gillette et al).

---

## Blacksheep Outlier Analysis
Full Reports: [Proteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/blacksheep_outlier/proteome_blacksheep_rmd.html)/[Phosphoproteome](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/blacksheep_outlier/phosphoproteome_blacksheep_rmd.html)/[RNA](http://prot-shiny-vm.broadinstitute.org:3838/panoply-tutorial/reports/blacksheep_outlier/rna_blacksheep_rmd.html)

For all the sample annotations specified in the `groups` file, the Blacksheep (Blumenberg et al) outlier analysis module identifies positive and negative outliers, and display tables (A) and plots (B) for each subgroup. The figure below shows outliers for the PAM50 Her2 subgroup in the proteome. Similar analyses are performed for each specified omics type---for the BRCA tutorial dataset, this include proteome, phosphoproteome and RNA. Results from outlier analysis were presented in **Figure 4 (c) / (d)** in (Mertins et al).

|  |  |
|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/outlier-1.png" alt="Outlier Fig 1" width="400"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/outlier-2.png" alt="Outlier Fig 2" width="400"> | 

---

## CMAP Analysis
The CMAP analysis module does not generate a HTML report. All results are contained in the `cmap` directory. As outlined in the `Description` section of the [`panoply_cmap_analysis`](https://github.com/broadinstitute/PANOPLY/wiki/Data-Analysis-Modules%3A-panoply_cmap_analysis) documentation page, this module identifies candidate driver genes using proteome profiles of copy number-altered samples (listed in `*-sig-genes-with-fdr.txt`). The number of copy number altered samples contributing to each candidate gene is plotted in `*sig-genes-extreme-samples.pdf` (A). The overlap with CMAP gene knockdown profiles is shown in `*sig-genes-overlap.pdf` (B) and corresponds to **Figure 2 (c)** in (Mertins et al). Additionally, enrichment of extreme samples in the various sample annotation groups specified in the `groups` file is tabulated in `*sig-genes-enrichment.csv`.

|  |  |
|:-:|:-:|
|(**A**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/cmap-1.png" alt="CMAP Fig 1" width="400"> | (**B**) <img src="https://raw.githubusercontent.com/broadinstitute/PANOPLY/dev/tutorial/results/images/cmap-2.png" alt="CMAP Fig 2" width="400"> | 

---

## References
* Mertins, P., Mani, D., Ruggles, K., Gillette, M., Clauser, K., Wang, P., Wang, X., Qiao, J., Cao, S., Petralia, F., et al. (2016). Proteogenomics connects somatic mutations to signalling in breast cancer. *Nature*  534(7605), 55 - 62. 
* Yoshihara, K., Shahmoradgoli, M., nez, E., Vegesna, R., Kim, H., Torres-Garcia, W., o, V., Shen, H., Laird, P., Levine, D., Carter, S., Getz, G., Stemke-Hale, K., Mills, G., Verhaak, R. (2013). Inferring tumour purity and stromal and immune cell admixture from expression data. *Nature Communications* 4(), 1 - 11. https://dx.doi.org/10.1038/ncomms3612.
* Zhang, B., Wang, J., XiaojingWang, Zhu, J., Liu, Q., Shi, Z., Chambers, M., Zimmerman, L., Shaddox, K., Kim, S., et al. (2014). Proteogenomic characterization of human colon and rectal cancer. *Nature* https://dx.doi.org/10.1038/nature13438
* Gillette, M., Satpathy, S., Cao, S., Dhanasekaran, S., Vasaikar, S., Krug, K., Petralia, F., Li, Y., Liang, W., Reva, B., et. al. (2020). Proteogenomic Characterization Reveals Therapeutic Vulnerabilities in Lung Adenocarcinoma. *Cell*  182(1), 200 - 225.e35.
* Aran, D., Hu, Z., Butte, A. (2017). xCell: digitally portraying the tissue cellular heterogeneity landscape. *Genome Biology*  18(1), 220. https://dx.doi.org/10.1186/s13059-017-1349-1.
* Blumenberg, L., Kawaler, E., Cornwell, M., Smith, S., Ruggles, K., Fenyö, D. (2019) BlackSheep: A Bioconductor and Bioconda package for differential extreme value analysis. *BioRxiv* Preprint https://doi.org/10.1101/825067.