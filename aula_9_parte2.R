#Queremos analisar as taxas de alfabetização do país, por estado

install.packages("rvest")
library(rvest)
install.packages("dplyr")
library(dplyr) #pacote para manipular dados
library(ggplot2)

#Fazer a "raspagem" de dados de um site na internet
# 1 - obter a url da pagina
# 2 - jogar a url no R para pegar os dados
# 3- raspagem de elementos do html
# 4 -manipular esse conjunto de dados

url <- "https://pt.wikipedia.org/wiki/Lista_de_unidades_federativas_do_Brasil_por_alfabetiza%C3%A7%C3%A3o"
html <- read_html(url)
html

html_elements(html,"h1") #Encontrar tags do html: pega as tags de "h1" que são os parágrafos do site
html_text2(html_elements(html,"h1")) #Extraindo o texto entre os h1

html |> #pipe
  html_elements("h1") |>
  html_text2()

#raspar os dados

tabelas <- html |>
  html_elements("table") |>
  html_table()

taxa <- tabelas[[3]]
taxa
