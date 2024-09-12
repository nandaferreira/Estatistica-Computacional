library(dplyr)
library(rvest) #para fazer a raspagem de dados. Lê o html, upa os dados para o R
library(stringr) #para fazer a manipulação dos dados

url <- "https://www.bosshunting.com.au/entertainment/movies/best-movies-imdb/"
html <- read_html(url)

nomes <- html |>
  html_elements("ol.wp-block-list") |>
  html_elements("li") |>
  html_text2()
nomes

#Criar o dataframe (tabela) com as 5 colunas: posição, título, ano, diretor, avaliação