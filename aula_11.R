library(dplyr)
library(rvest) #para fazer a raspagem de dados. Lê o html, upa os dados para o R
library(stringr) #para fazer a manipulação dos dados

#Web scraping: processo de extrair informações de dados de páginas web
#HTML: HyperText Markup Language (consigo traduzir essa informação em código)
#Faremos a raspagem de dados de dois sites. 
#Primeiro: timeout, melhores filmes de terror (csv) - https://www.timeout.com/film/best-horror-films
#Segundo: bosshunting, melhores filmes de todos os tempos - https://www.bosshunting.com.au/entertainment/movies/best-movies-imdb/

#p -> seleciona todos os elementos de <p>
#.title -> seleciona o elemento com a classe "title"

url <- "https://www.timeout.com/film/best-horror-films"
html <- read_html(url)

nomes <- html |>
  html_elements("h3._h3_cuogz_1") |> #Quero pegar todos os elementos "h3" que tem a classe "h3_cuogz"
  html_text2()

#primeira coluna: ranking do film, segunda: nome, terceira: ano

posicao <- str_extract_all(string = nomes, pattern = "^\\d+") #Extraia os números que estão no começo da frase. "âncora"
posicao <- unlist(posicao)
posicao <- as.numeric(posicao)

anos <- str_extract_all(nomes, "\\(\\d+\\)$") #o \\ é só pra indicar o que eu quero tirar
anos <- unlist(anos)
anos <- str_extract_all(anos,"\\d+")
anos <- unlist(anos)
anos

titulos <- str_remove_all(nomes, "^\\d+\\.\\s+")
titulos <- str_remove_all(titulos, "\\s+\\(\\d+\\)$")

filmes_horror <- data.frame(posicao, titulos, anos) #coloca vetores dentro de uma tabela
write.csv(filmes_horror, file = "filmes_horror.csv", row.names = FALSE)
