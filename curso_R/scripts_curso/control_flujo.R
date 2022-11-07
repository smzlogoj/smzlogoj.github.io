### BUCLES ####


for(i in 1:10) print(i)

estaciones <- c('Invierno', 'Primavera', 'Verano', 'Otoño')
for(estacion in estaciones){
  print(estacion)
}

head(mtcars)
colnames(mtcars)

for(variable in colnames(mtcars)){
 media <- mean(mtcars[, c(variable)])
 print(paste(variable, media, sep = ' : '))
}

apply(mtcars, 2, mean) ### se mueve por columnas
apply(mtcars, 1, mean) ### se mueve por filas


contador <- 1
while (contador < 10){
  print(contador)
  contador <- contador + 1
}


#condicionales

numeros <- 1:20
numeros

for(numero in numeros){
  modulo <- numero %% 2
  if(modulo == 0){
    print(paste0(numero, ' es par'))
  } else {
    print(paste0(numero, ' es impar'))
  }
}

## ifelse
df
df$x3 <- df$x2 - df$x1
df
df$x3 <- ifelse(df$x3 < 0, 0, df$x3)
df
df$x3 <- NULL


X1 <- round(runif(10, min = 0.1, max = 25), 2)
X1
X2 <- round(runif(10, min = 10, max = 35),2)
X2
df_2 <- data.frame(muestra = paste(c("m"), 11:20, sep="_"),
                 tipo = c(rep(c('C', 'T'), 5)),
                 x1 = X1,
                 x2 = X2)
df_2
df
rbind(df, df_2)

df_3 <- data.frame(x4 = round(runif(10, min = 50, max = 100), 2),
                   x5 = round(runif(10, min = 5, max = 10), 2),
                   x6 = round(runif(10, min = -5, max = 5), 2))
df_3
df
cbind(df, df_3)
