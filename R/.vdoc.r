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
#| label: create-vectores

vector_numeros <- c(2, 4, 6, 8)

vector_numeros

seq_numeros <- seq(2, 6)
seq_numeros

seq_numeros2 <- 2:6
seq_numeros2

seq_numeros3 <- seq(2, 6, by = 0.5)
seq_numeros3
```
#
#
#
#| label: combine-vector

vector_numeros2 <- c(1, 3, 5)
vector_numeros2 <- c(vector_numeros2, 7)

vector_numeros2

comb_vector <- c(vector_numeros, vector_numeros2)
comb_vector

vector_caracteres <- c('A', 'B', 'C')
vector_caracteres


vector_logico <- c(TRUE, FALSE, TRUE)
vector_logico

vector_logico2 <- 10 == 5
vector_logico2
```
#
#
letras <- c('A', 'B', 'C')
letras

letras_rep <- rep(letras, times = 3)
letras_rep

letras_rep2 <- rep(letras, each = 3)
letras_rep2
```
#
#
#
#
#
vector_numeros <- seq(10, 50, by = 5)
vector_numeros

vector_numeros + 1

vector_numeros / 2
#
#
#
#
vector_numeros_1 <- c(1, 2, 3, 4)
vector_numeros_2 <- c(1, 1, 0, 0)

vector_numeros_1 + vector_numeros_2
vector_numeros_1 - vector_numeros_2
vector_numeros_1 * vector_numeros_2
vector_numeros_1 / vector_numeros_2
```
#
#
#
#
vector_numeros_1 <- c(1, 2, 3, 4, 5, 6)
vector_numeros_2 <- c(1, 1, 0)

vector_numeros_1 + vector_numeros_2
vector_numeros_1 - vector_numeros_2
vector_numeros_1 * vector_numeros_2
vector_numeros_1 / vector_numeros_2
```
#
#
#
#
#
#
#
#
letras <- c('A', 'B', 'C', 'D')
numeros <- c(1, 2, 3, 4, 5)

resultado = paste(letras, numeros, sep="-")
resultado
```
#
#
#
numeros <- c(1, 2, 3, 4, 5)
numeros
texto_numeros <- as.character(numeros)
texto_numeros
```
#
#
#
#
#
numeros <- 10:20
numeros
```
#
#
numeros[4]
```
#
#
#
numeros[-4]

numeros[c(4, 8)]
numeros[c(4:8)]
numeros[-c(4:8)]
#
#
#
#
numeros <- 10:20
numeros
numeros <- numeros[-c(1, 5)]
numeros
```
#
#
numeros
numeros <- c(numeros, c(50, 100))
numeros
```
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
numeros
order(numeros, decreasing = TRUE)
```
#
#
numeros[order(numeros, decreasing = TRUE)]
```
#
#
#
#
numeros <- 10:20
numeros

numeros < 15

numeros[numeros <15]
#
#
#
#
#
#
log2FoldChange <- c(-5.3823, -1.2634, -1.0972, -1.0904, -0.9888, -0.9792)

log2FoldChange

ensembles <- c('ENSMUSG00000020000', 
               'ENSMUSG00000060036', 
               'ENSMUSG00000060613', 
               'ENSMUSG00000038092', 
               'ENSMUSG00000020926', 
               'ENSMUSG00000001435')
ensembles

names(log2FoldChange) <- ensembles

log2FoldChange

log2FoldChange['ENSMUSG00000060613']
log2FoldChange[c('ENSMUSG00000060613', )]
#
#
#
