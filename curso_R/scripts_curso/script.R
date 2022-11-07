## Tipos de Datos Básicos

entero <- 1
numero <- 1.0
complejo <- 3 + 2i
caracter <- 'un texto'
logico <- TRUE
logico2 <- FALSE
logico3 <- 1 < 2
# factor    as.factor()

numero <- (5 *6) + 2
numero
numero <- numero + 1
numero

## Vectores

x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
x
1/x
y <- c(x, 0, x)
y
## Vector arithmetic
v1 <- c(1, 2, 3)
v2 <- c(1, 1, 1)
v <- 2*v1 + v2 + 1
v


v1 <- c(1,2)
v2 <- c(2,1)

v3 <- v1 * v2
v3
v1
tv2 <- t(v2)
v4 <- v1 %*% t(v2)
v4
v4 * v4
v4 %*% v4


mean(x)
length(x)
sd(x)
min(x)
max(x)
sum(x)
sum((x-mean(x))^2)/(length(x)-1)

## Secuencias

v <- 1:30
v
v <- 30:1
v
v <- seq(-5, 5, by = 0.2)
v
v <- seq(length = 50, from = -5, by = 0.25)
v
v <- rep(c(2.5, 5.0), times = 5)
v
vc <- rep('Hola', times = 10)
vc

### Solo un tipo de datos
vect <- c(1, '1')
vect

## Missing values (NA)
z <- c(1:5, NA)
z
is.na(z)

0/0

### vectores de caracteres
a <- 'Hola'
b <- 'Mundo'
saludo <- paste(a, b, sep = ' ')
saludo
saludo <- paste0(a, ' ', b)
saludo

labs <- paste(c("X"), 1:10, sep="")
labs
## Vectores indices
x <- c(1:10)
x
x[4:8]


x
x <- c(x,  2.5, 6.0)
x

x[c(2,4)] # valores de las posiciones 2 y 4
x

x > 6
x[x > 6]

### OBJETOS

z <- 1:10
z
digitos <- as.character(z)
digitos
d <- as.integer(digitos)
d

d[5] <- 20
d
d[d < 7] <- 10
d


### LISTAS
Lista <- list(name="Fred", wife="Mary", no.children=3, child.ages=c(4,7,9))
Lista
Lista$child.ages     ###Lista[[4]]
Lista$wife           ###Lista[[2]]


str(Lista)

#### DATA FRAMES

Muestra <- paste(c("m"), 1:10, sep="_")
Muestra
Tipo <- c(rep(c('C', 'T'), 5))
Tipo
X1 <- runif(10, min = 0.1, max = 25)
X1
X2 <- runif(10, min = 10, max = 35)
X2
df <- data.frame(muestra = Muestra,
                 tipo = Tipo,
                 x1 = X1,
                 x2 = X2)
df
summary(df)
str(df)
df$muestra
df$x1

## round
df$x1 <- round(df$x1, 2)
df$x2 <- round(df$x2, 2)
df
df$x3 <- runif(10, min = 0, max = 5)
df
df$x3 <- NULL
df
df$x3 <- df$x2 - df$x1
df

colMeans(df) ### Error in colMeans(df) : 'x' must be numeric
### Documentacion colMeans
df[, c('x1', 'x2', 'x3')]
df[, 3:5]
colMeans(df[, c('x1', 'x2', 'x3')])

df
df[c(1,3,5,7,9), ]

df[df$tipo == 'C',]
df[df$tipo == 'T', ]
df$tipo == 'T'
df$tipo != 'T'
df[df$tipo == 'T', c('x1', 'x3')]
df[df$x3 < 0, c(1:3, 5)]

### documentacion
sd(df[, 3])
mean(df[, 3])
df$x3 <- NULL
df

aggregate(df[, c('x1', 'x2')], by = list(df$tipo), FUN = 'mean')
aggregate(df[, c('x1', 'x2')], by = list(df$tipo), FUN = 'sd')
aggregate(df[, c('x1', 'x2')],
          by = list(df$tipo),
          FUN = function(valor){cv = sd(valor) * 100 / mean(valor)})


## mtcars
## http://www.sthda.com/english/wiki/r-base-graphs
mtcars


plot(mtcars$wt, mtcars$mpg, pch = 19)
pairs(mtcars)



barplot(mtcars$hp)

hist(mtcars$hp)

grps <- as.factor(mtcars$cyl)
my_cols <- c("#999999", "#E69F00", "#56B4E9")
dotchart(mtcars$mpg, labels = row.names(mtcars),
         groups = grps, gcolor = my_cols,
         color = my_cols[grps],
         cex = 0.6,  pch = 19, xlab = "mpg")


boxplot(hp ~ cyl, data = mtcars,
        frame = FALSE, col = c("#999999", "#E69F00", "#56B4E9"))


shapiro.test(mtcars$hp)

t.test(mtcars[mtcars$cyl == 4, ]$hp, mtcars[mtcars$cyl == 8, ]$hp)
#wilcox.test(mtcars[mtcars$cyl == 4, ]$hp, mtcars[mtcars$cyl == 8, ]$hp)

anova <- aov(hp ~ as.factor(cyl), data = mtcars)
summary(anova)
TukeyHSD(anova)
plot(TukeyHSD(anova))


## Correlaciones
df
plot(mtcars$mpg, mtcars$hp)
#shapiro.test(mtcars$mpg) ; shapiro.test(mtcars$hp)
cor(mtcars[, c('mpg', 'hp')])
cor(mtcars[, c('mpg', 'hp')], method = 'spearman')

cor.test(mtcars$mpg, mtcars$hp)
cor.test(mtcars$mpg, mtcars$hp, method = 'spearman')

cor(mtcars)
cov(mtcars$mpg, mtcars$mpg)
var(mtcars$mpg)
sd(mtcars$mpg)^2
cov(mtcars)

