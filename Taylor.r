install.packages("urca")
library(urca)
install.packages("vars")
library(vars)
install.packages("mFilter")
library(mFilter)
install.packages("tseries")
library(tseries)
library(forecast)
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
library(readxl)
VAR_Taylor <- read_excel("C:/Users/jhona/Desktop/Brayan/Github/Politica-Economica/Bases de datos/VAR Taylor.xlsx")
View(VAR_Taylor)

Taylor <- VAR_Taylor


#Graficamos la correlaci?n entre los datos mediante un diagrama de dispersi?n

ggplot(data = Taylor) + geom_point(mapping = aes(x= DIF, y= varpib ))

##Declaramos las variables como series de tiempo

gdp <- ts(Taylor$varpib, start = c(2003,3), frequency= 4)
inflation <- ts(Taylor$DIF, start = c(2003,3), frequency = 4)

#Graficar las series de tiempo
autoplot(cbind(gdp,inflation))
autoplot(cbind(inflation))
autoplot(cbind(gdp))

#Observemos la correlaci?n entre las variables usando una regresi?n

regresionlineal1 <- lm(inflation ~ gdp)
summary(regresionlineal1) #Resultado de la regresi?n

regresion2 <- lm(gdp ~ inflation)
summary(regresion2)

#Calculando los correlogramas

#Primero vamos a calcular los correlogramas para la serie PIB

acf(gdp, main ="ACF crecimiento del PIB Real" )  #AUTOCORRELOGRAMA=acf
pacf(gdp, main ="PACF crecimiento del PIB Real" ) #AUTOCORRELOGRAMA PARCIAL=pacf

acf(inflation, main = "ACF tasa de desempleo ")
pacf(inflation, main = "PACF tasa de desempleo")

#Encontrando la cantidad de rezagos ?ptimas

taylor.bv <- cbind(gdp, inflation)
colnames(taylor.bv) <- cbind("GDP", "Inflation")
view(taylor.bv)
lagselect <- VARselect(taylor.bv, lag.max = 10, type = "const")
lagselect$selection

#Construir el modelo

ModelTaylor1 <- VAR(taylor.bv, p = 2, type = "const", season = NULL, exog= NULL)
summary(ModelTaylor1)

#Diagn?stico del VAR  

Serial1 <- serial.test(ModelTaylor1, lags.pt = 12, type= "PT.asymptotic")
Serial1
##Si el P-valor obtenido en el test realizado es mayor a 0.05
#Encontramos que el modelo no tiene correlaci?n serial
#Si por el contrario fuera menor a 0.05, si tendr?a problemas
#De correlaci?n serial.

#Test de heterocedasticidad "Efecto ARCH"
Arch1 <- arch.test(ModelTaylor1, lags.multi = 12, multivariate.only = TRUE)
Arch1
#Este test ARCH es como un test de Jarque Bera.
#Si el p-valor es mayor a 0.05, no rechazo la hip?tesis nula
#Por lo tanto este modelo no tiene efecto ARCH por lo que no es Heteroced?stico


#Distribuci?n normal de los errores

Normal1 <- normality.test(ModelTaylor1, multivariate.only = TRUE)
Normal1

#Si el test de JB PARA NORMALIDAD me muestra que el p-valor es menor a 0.05
#Encontramos que el modelo no sigue una distribuci?n ruido blanco
#Pero ASUMIMOS que la distribuci?n de los errores es normal (Por ahora)
#para continuar con el an?lisis


#Test para fallas estructurales

Stability <- stability(ModelTaylor1, type = "OLS-CUSUM")
plot(Stability)

#Siempre y cuando la linea negra, que representa el proceso generador de datos
#est? por dentro de los intervalos de confianza, el modelo no tendr? 
#errores estructurales


#Causalidad de Granger

GrangerGDP <- causality(ModelTaylor1, cause = "GDP")
GrangerGDP

#No hay causalidad en el sentido de Granger del GDP al desempleo

GrangerUNM <- causality(ModelTaylor1, cause = "Inflation")
GrangerUNM

#Si hay causalidad en el sentido de Granger de la Inflaci?n al GDP

#Funciones impulso-respuesta

GDPirf <- irf(ModelTaylor1, impulse = "Inflation", response = "GDP", n.ahead = 20, boot = TRUE)
plot(GDPirf, ylabel = "GDP", main = "Choque de la Inflaci?n")


UNEMirf <- irf(ModelTaylor1, impulse = "GDP", response = "Inflation", n.ahead = 20, boot = TRUE)
plot(UNEMirf, ylabel = "Inflacion", main = "Choque del GDP")

#Descomposici?n de la varianza

FEVD1 <- fevd(ModelTaylor1, n.ahead = 10)
plot(FEVD1)

#Pron?stico del VAR

forecast1 <- predict(ModelTaylor1, n.ahead = 4, ci = 0.95)
fanchart(forecast1, names = "GDP")
fanchart(forecast1, names = "Inflation")


