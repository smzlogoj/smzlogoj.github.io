#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: load-packages
library(gprofiler2)

```
#
#
#| label: Cargar-datos

df.fc <- read.csv('../rnaseq/deseq/data/resultado.csv')
df.fc <- df.fc[order(df.fc$log2FoldChange, decreasing = TRUE), ]

padj.cutoff <- 0.05
lfc.cutoff <- log2(1.5)

genes.up <- df.fc$X[df.fc$log2FoldChange >= lfc.cutoff & df.fc$padj <= padj.cutoff]
genes.down <- df.fc$X[df.fc$log2FoldChange <= -1 * lfc.cutoff & df.fc$padj <= padj.cutoff]

genes.dge <- c(genes.up, genes.down)
allgenes <- df.fc$X
```
#
#| label: ejecutar-gprofiler

gost.res <- gost(query = genes.dge,
                organism = 'hsapiens',
                ordered_query = TRUE,
                correction_method = 'fdr',
                custom_bg = allgenes,
                highlight = TRUE
                )

head(gost.res$result, 3)
```
#
#
#
#| label: gprofiler-plot

gostplot(gost.res, capped = TRUE, interactive = TRUE)
#
#
#
#| label: link
gost.link <- gost(query = genes.dge,
                organism = 'hsapiens',
                ordered_query = TRUE,
                correction_method = 'fdr',
                custom_bg = allgenes,
                highlight = TRUE, 
                as_short_link = TRUE
                )

gost.link
#
#
#
#
#
#
#| label: REVIGO

gprofiler_results <- gost.res$result[order(gost.res$result$p_value, decreasing = TRUE),]
gprofiler_results <- gprofiler_results[grep('GO:', gprofiler_results$term_id), ]

GO.pval <- gprofiler_results[, c('term_id', 'p_value')]

write.table(GO.pval, "results/GOs_oe.txt", quote=FALSE, row.names = FALSE, col.names = FALSE)

head(GO.pval)
#
#
#
