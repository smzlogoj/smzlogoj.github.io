#### Cargar las librerias

library(DESeq2)

#### Cargar dataset raw counts
df <- read.csv('mcf_count_table.csv')
class(df)
dim(df)
head(df)

### Cargar metadatos
metadata <- read.csv('mcf_metadata.csv')
dim(metadata)
head(metadata)


### Seleccionar muestras fenotipos de interes
fenotipos <- c('L1Larvae', 'L2Larvae')

df.fenotipos <- metadata[metadata$stage %in% fenotipos, c('sample.id', 'stage')]
df.fenotipos

### Seleccionar columnas en raw counts correspondientes a las muestras de los fenotipos

names(df)

df.sub <- df[, df.fenotipos$sample.id]

head(df.sub)

### Añadir la informacion de los genes
rownames(df.sub) <- df$gene
head(df.sub)

### Eliminar genes con pocas counts

head(rowSums(df.sub))
head(rowSums(df.sub) > 10)

keep <- rowSums(df.sub) > 10

df.sub <- df.sub[keep, ]

### Crear objeto DEseqDataSet
coldata <- data.frame(stage = df.fenotipos$stage)
rownames(coldata) <- df.fenotipos$sample.id
coldata

dds <- DESeqDataSetFromMatrix(countData = df.sub, 
                              colData = coldata, 
                              design = ~stage)

### realizar análisis
dds <- DESeq(dds)

res <- results(dds, contrast= c('stage', 'L1Larvae', 'L2Larvae'))
res

df.fc <- as.data.frame(res)

summary(df.fc)

df.fc <- df.fc[complete.cases(df.fc), ]

summary(df.fc)

### Volcano Plot
padj.cutoff <- 0.0000001
lfc.cutoff <- log2(2.5)

df.fc$class <- 'none'
df.fc[df.fc$log2FoldChange >= lfc.cutoff & df.fc$padj <= padj.cutoff, c('class')] <- 'UP'
df.fc[df.fc$log2FoldChange <= -1 * lfc.cutoff & df.fc$padj <= padj.cutoff, c('class')] <- 'DOWN'

library(ggplot2)

ggplot(df.fc, aes(x = log2FoldChange, y = -1 * log10(padj))) +
  geom_point(aes(color = class)) +
  geom_hline(yintercept = -1 * log10(padj.cutoff), linetype = 'dashed') +
  geom_vline(xintercept = c(-1* lfc.cutoff, lfc.cutoff), linetype = 'dashed') +
  theme_bw()


df.deg <- df.fc[df.fc$class != 'none', ]
df.deg <- df.deg[order(df.deg$log2FoldChange, decreasing = TRUE), ]

genes.up <- rownames(head(df.deg, 30))
genes.down <- rownames(tail(df.deg, 20))

genes.dge <- c(genes.up, genes.down)

#### Cuentas normalizadas

df.norm <- log2(counts(dds, normalized = TRUE) + 1)
df.norm <- df.norm[rownames(df.norm) %in% genes.dge, ]


#### Convertir ensembl
library(org.Dm.eg.db)
keytypes(org.Dm.eg.db)

genes <- mapIds(org.Dm.eg.db, 
                keys = genes.dge, 
                keytype = 'ENSEMBL', colum = 'SYMBOL')
genes
genes <- as.data.frame(genes)
genes

### MERGE
df.norm <- merge(df.norm, genes, by = 'row.names')
rownames(df.norm) <- df.norm$genes


### VALORES DUPLICADOS
duplicated(genes)
genes[duplicated(genes), ]

rownames(df.norm) <- make.unique(df.norm$genes)

df.norm[df.norm$genes == 'CG14454', ]


### HEATMAP
library(pheatmap)
pheatmap(df.norm[, df.fenotipos$sample.id], 
         scale = 'row', 
         cutree_cols = 2,
         cutree_rows = 2,
         annotation_col = coldata, 
         fontsize_row = 6,
         fontsize_col = 12
         )




