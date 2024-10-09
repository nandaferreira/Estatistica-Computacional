#criar um modelo de classificação de texto
#a ideia é dizer o quão importante a palavra é para o texto ou dizer sobre o tema

install.packages("tidytext")
library(tidytext)
library(dplyr)
library(ggplot2)
install.packages("tidyr")
library(tidyr)
install.packages("stopwords")
library(stopwords) #contém as "stopwords" de cada linguagem
library(rvest) #essa serve para a raspagem de dados

url <- "https://www.bbc.com/portuguese/articles/c3dv8yy3d8jo"

html <- read_html(url)
texto <- html |>
  html_elements("p.bbc-hhl7in") |>
  html_text2() |>
  paste(collapse = " ") #por que collapse e porque em branco entre as aspas?


texto <- paste(texto, collapse = " ")
conjunto <- data.frame(texto)
conjunto

#pedir para ela contar as repitições das palavras

conjunto |>
  unnest_tokens(output = word, input = texto) |>
  count(word, sort = TRUE) |>
  top_n(10) #pega só as 10 mais

#sort é pra ordenar das mais frequentes para as menos frequentes

stopwords_br <- data.frame(word = stopwords("pt"))

conjunto |>
  unnest_tokens(output = word, input = texto) |>
  anti_join(stopwords_br) |>
  count(word, sort = TRUE) |>
  top_n(10) |>
  mutate(word = reorder(word, n))|>
  ggplot(aes(y = word, x = n))+
  geom_col(fill = "#bcbddc")+
  labs(title = "10 palavras mais frequentes no texto")
  theme_minimal()
  
#geometria que eu quero, nesse caso, é de coluna (perguntar pq)

install.packages("janeaustenr")  
library(janeaustenr)
livro <- prideprejudice

livro <- data.frame(texto = livro) #nao entendi por que "texto"
stopwords_en <- data.frame(word = stopwords("en"))

livro |>
  unnest_tokens(word, texto) |>
  anti_join(stopwords_en) |>
  count(word, sort = TRUE) |>
  top_n(10) |>
  mutate(word = reorder(word,n)) |>
  ggplot(aes(y = word, x = n))+
  geom_col(fill = "#3182bd")+
  theme_minimal()

#"buscar sentimentos" na biblioteca

sentimentos <- get_sentiments("bing")
library(stringr)
capitulos <- str_detect(livro$texto, "^Chapter \\d+")
capitulos <- cumsum(capitulos)

livro |>
  mutate(capitulo = capitulos) |> #cria coluna (recebe os capitulos que acabei de criar)
  unnest_tokens(word, texto) |>
  inner_join(sentimentos) |>
  count(capitulo, sentiment) |>
  spread(sentiment, n, fill = 0) |>
  mutate(total = positive - negative) |>
  ggplot(aes(x = capitulo, y = total))+
  geom_col()+ 
  theme_minimal()

livro$texto[1:10]
