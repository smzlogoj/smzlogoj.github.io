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

library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(pathview)
#
#
#
#
#
#
#| label: load-data

df.fc <- read.csv('../rnaseq/deseq/data/resultado.csv')

padj.cutoff <- 0.05
lfc.cutoff <- log2(1.5)

genes.up <- df.fc$X[df.fc$log2FoldChange >= lfc.cutoff & df.fc$padj <= padj.cutoff]
genes.down <- df.fc$X[df.fc$log2FoldChange <= -1 * lfc.cutoff & df.fc$padj <= padj.cutoff]

## datos para pathway
geneList <- df.fc$log2FoldChange[df.fc$X %in% c(genes.up, genes.down)]
names(geneList) <- c(genes.up, genes.down)
geneList <- geneList[order(geneList, decreasing = TRUE)]


genes.dge <- c(genes.up, genes.down)
allgenes <- df.fc$X
```
#
#
#
#
#
#
#| label: GO-BP

go.BP <- enrichGO(gene          = genes.dge,
                  universe      = allgenes,
                  OrgDb         = org.Hs.eg.db,
                  keyType       = "SYMBOL",
                  ont           = "BP",
                  pAdjustMethod = "BH"
                )

head(go.BP)
```
#
#| label: barplot-gobp
#| fig-height: 8

barplot(go.BP, showCategory = 15)
dotplot(go.BP, showCategory = 15)
#
#
#
#
#
#| label: GO-mf

go.MF <- enrichGO(gene          = genes.dge,
                  universe      = allgenes,
                  OrgDb         = org.Hs.eg.db,
                  keyType       = "SYMBOL",
                  ont           = "MF",
                  pAdjustMethod = "BH"
                )

head(go.MF)
```
#
#| label: barplot-gomf
#| fig-height: 8

barplot(go.MF, showCategory = 15)
dotplot(go.MF, showCategory = 15)
#
#
#
#
#
#| label: GO-CC

go.CC <- enrichGO(gene          = genes.dge,
                  universe      = allgenes,
                  OrgDb         = org.Hs.eg.db,
                  keyType       = "SYMBOL",
                  ont           = "CC",
                  pAdjustMethod = "BH"
                )

head(go.CC)
```
#
#| label: barplot-gocc
#| fig-height: 8

barplot(go.CC, showCategory = 15)
dotplot(go.CC, showCategory = 15)
#
#
#
#
#
#
#| label: enrichKegg

allgenes.entrezid <- bitr(allgenes, 
                          fromType = 'SYMBOL',
                          toType = 'ENTREZID',
                          OrgDb = 'org.Hs.eg.db'
                          )
genes.dge.entrezid <- bitr(genes.dge, 
                          fromType = 'SYMBOL',
                          toType = 'ENTREZID',
                          OrgDb = 'org.Hs.eg.db'
                          )
head(genes.dge.entrezid)
```
#
kegg <- enrichKEGG(gene         = genes.dge.entrezid$ENTREZID,
                   organism     = 'hsa',
                   universe     = allgenes.entrezid$ENTREZID)

head(kegg)
#
#
#
#| label: dotplot-kegg

dotplot(kegg, showCategory = 15)
#
#
#
#
#
#
#| label: hsa04512
browseKEGG(kegg, 'hsa04512')
```
#
#
#
#| label: hsa04151
browseKEGG(kegg, 'hsa04151')
```
#
#
#
#
#

genes.dge.entrezid <- bitr(names(geneList), 
                          fromType = 'SYMBOL',
                          toType = 'ENTREZID',
                          OrgDb = 'org.Hs.eg.db'
                          )
names(geneList) <- genes.dge.entrezid$ENTREZID
#
#
#
#| label: hsa04512
hsa04512 <- pathview(gene.data  = names(geneList),
                     pathway.id = "hsa04512",
                     species    = "hsa",
                     limit      = list(gene=max(abs(geneList)), cpd=1))
```
#
#
#
#| label: hsa04512
hsa04151<- pathview(gene.data  = names(geneList),
                     pathway.id = "hsa04512",
                     species    = "hsa",
                     limit      = list(gene=max(abs(geneList)), cpd=1))
```
#
#
#
#
#
#
#
#| label: citation

citation("clusterProfiler")

#
#
#
#
