install.packages("installr")
library(installr)
install.packages("RSelenium")
library(RSelenium)
install.packages("tidyverse")
library(tidyverse)
install.packages("rvest")
library(rvest)
install.packages("stringr")
library(stringr)
install.packages("xml2")
library(xml2)
install.packages("robotstxt")
library(robotstxt)
install.packages("robotstxt")
library(dplyr)
install.packages("xml")
library(xml)

updateR() 
# Link Inical 
Url <- "https://es.investing.com/equities/bcolombia-historical-data"

# preguntar si esta permitido trabajar con la pagina 

paths_allowed(paths= c(Url))
# leer el contenido de la html

html_web <-read_html(Url)
css_producto <-"table.genTbl.closedTbl.historicalTbl"

Producto_html <- html_nodes(html_web,css_producto)
Producto_html
#limpiar texto 
Producto_texto <- html_text(Producto_html)
Producto_texto

Fecha <-html_web %>% html_nodes("td.first.left.bold.noWrap") %>% html_text("") 
Fecha
data.class(Fecha )

                   
                   




#seleccinar 
Producto_texto[[3]]
data.class( Producto_texto[[3]] )







#////////////////////////////////////////////////////////////////////////////////////////////

# Link Inical 
Url1 <- "https://www.bbva.com.co/personas/productos/inversion/fondos/pais.html"
html_web1 <-read_html(Url1)
# leer el contenido de la html
html_web1 <-read_html(Url1)
css_producto1 <-"div"

Producto_html1 <- html_nodes(html_web1,css_producto1) 
Producto_html1
#selecionar datos, leer html 
Producto_texto <- html_text(Producto_html1) 
Producto_texto 
#tipo de objecto
data.class( Producto_texto[11])
Producto_texto[[3]]





























#Exibir los datos
length(Producto_html)
tail(Producto_html)




titulo <-html_web %>% html_nodes("td.gray-bg-titles") %>% html_text("")
titulo


webpage =read_html(Url)

title <- webpage %>% html_nodes("") %>%  html_text()
head(title)




# cargo el drive  

URL <-("https://www.bbva.com.co/personas/productos/inversion/fondos/pais.html")


drive<- rsDriver(browser=c("firefox"))
remote_drive<-drive[["client"]]

driver <- remoteDriver()
driver$open()
driver$navigate()


rD <- rsDriver()
remDr <- rD[["client"]]
remDr$navigate("http://www.google.com/")


ses_rvest<-html_session("Url")




















