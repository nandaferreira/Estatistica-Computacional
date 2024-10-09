library(janeaustenr)
library(tidytext) #analise dos textos
library(dplyr)
library(ggplot2)
library(stringr)
library(stopwords)
library(tidyr) #contém a função "spread". ela transforma conjuntos "desorganizados" em uma amostra visualmente melhor

livros <- austen_books() 
unique(livros$book)

livros |>
  filter(book == "Emma") |>
  unnest_tokens(word,text) |>
  count(word, sort = TRUE) |>
  top_n(10)

stop_words_en <- data.frame(word = stopwords("en"))

livros |>
  filter(book == "Emma") |>
  unnest_tokens(output = word, input = text) |>
  anti_join(stop_words_en) |>
  count(word, sort = TRUE) |> #"count" é o contador de frequência das palavras
  top_n(10)

emma <- livros |>
  filter(book == "Emma")

capitulos <- str_detect(emma$text, "^CHAPTER [IVXCDLM]+")
capitulos <-cumsum(capitulos)
capitulos
emma$capitulos <- capitulos
str(emma)

emma |>
  unnest_tokens(output = word, input = text) |>
  anti_join(stop_words_en) |>
  inner_join(get_sentiments("bing")) |>
  count(capitulos, sentiment) |>
  spread(sentiment, n, fill = 0) |>
  mutate(total = positive - negative) |>
  ggplot(aes(x= capitulos, y = total))+
  geom_col()

livros|>
  group_by(book) |>
  mutate(capitulos = cumsum(str_detect(text, regex("^chapter (\\d | [IVXLCDM])+", ignore_case = TRUE))))|>
  ungroup() |>
  unnest_tokens(word, text) |>
  anti_join(stop_words_en) |>
  inner_join(get_sentiments("bing"), relationship = "many-to-many") |>
  count(book, capitulos, sentiment) |>
  spread(sentiment, n, fill = 0) |>
  mutate(total = positive - negative) |>
  ggplot(aes(x= capitulos, y = total, fill = book))+
  geom_col(show, legend = FALSE) +
  facet_wrap(-book, scales = "free_x")+
  theme_minimal()

#na linha 32 ele consegue identificar quais são as linhas que começam com a palavra "capitulo", e assim vou identificar quantos capitulos tenho no livro
#nesse caso funciona porque eu sei que o padrão do livro é esse (capítulo no inicio da linha). Ficar atenta na hora de analisar outra obra/data frame

#livros[livros$book == "Emma,]

#na linha 16 vou criar uma coluna chamada "word" e tenho que falar qual a  coluna do conjunto que eu quero usar. Especificar o texto de entrada que eu quero usar

#linha 42: analisar os sentimentos por capítulo, não do livro todo

#LINHA 49: "regex" é para ignorar a diferenciação de letras maiúsculas e minúsculas