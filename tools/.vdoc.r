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
#
#| label: load-data
df.mcf <- read.csv('data/mcf_normalized_counts.csv', row.names = 1)


head(df.mcf)
#
#
#
#
#
#
#
#| label: identificar-database
library(biomaRt)

listEnsembl()
ensembl <- useEnsembl(biomart = 'genes')

ensembl
#
#
#
#
#| label: dataset

searchDatasets(mart = ensembl, pattern = 'melanogaster')
#
#
#
#
#
#| label: selec-database

ensembl <- useEnsembl(biomart = 'genes', dataset = 'dmelanogaster_gene_ensembl')

ensembl
#
#
#
#
#| label: query

genesBM <- getBM(filters = 'ensembl_gene_id', 
                  attributes = c("ensembl_gene_id","entrezgene_id",'external_gene_name'),
                  values = rownames(df.mcf),
                  mart = ensembl
                 )

head(genesBM)
```
#
#
#
#
#
#
head(genesBM[duplicated(genesBM$external_gene_name), ], 10)
#
#
#
#
#| label: dimensiones
dim(df.mcf)

dim(genesBM)
#
#
#
#
#
#| label: left-join

library(reshape2)
samples <- names(df.mcf)
df.mcf$ensembl_gene_id <- rownames(df.mcf)

df <- merge(df.mcf, genesBM, 
            by =  'ensembl_gene_id', 
            all.x = TRUE)
df <- df[, c('ensembl_gene_id', 'entrezgene_id', 'external_gene_name', samples)]

head(df)
```
#
#
#| label: duplicados

head(df[duplicated(df$ensembl_gene_id), ], 10)
```
#
#
#| label: datos-faltantes

head(df[!complete.cases(df),])
dim(df[!complete.cases(df),])
#
#
#
