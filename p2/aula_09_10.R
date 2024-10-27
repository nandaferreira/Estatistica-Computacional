#Teorema de Bayes
#Dado o teste positivo, qual a probabilidade da criança realmente vir a óbito
#O teste pode dar positivo mesmo com a criança não tendo a doença (probabilidade condicional)

numerador<-(1/5000)*0.99 #probabilidade de ter a doença * 
denominador <- ((1/5000)*0.999)+ ((4999/5000)*(1 - 0.999))

numerador/denominador
20*0.999
999980*(1 - 0.999)
20/1020
#--------------------------------------------------------------------------------------------------

noticias <- read.csv(file = "noticias.csv", header = TRUE)
#Vamos filtrar o conjunto de notícias e selecionar só as notícias de "Saúde"
library(dplyr)
library(tidytext)
install.packages("SnowballC") #lematização / radiciação
library(SnowballC)
install.packages("quanteda") #analise quantitativa
library(quanteda)
library(quanteda.textmodels) #modelagem de text

stopwords_pt <- data.frame(word = stopwords("pt"))

noticias[1,] |>
  unnest_tokens(word,texto) |>
  anti_join(stopwords_pt) |>
  count(word, sort = TRUE) |>
  top_n(20)

noticias[1,] |>
  unnest_tokens(word,texto) |>
  anti_join(stopwords_pt) |>
  mutate(word = wordStem(word, "portuguese")) #wordStem faz a "lematização" da coluna "word"

count(word, sort = TRUE) |>
  top_n(20)
#acho no vetor as palavras que eu quero "tokenizar" (o que é isso meu deus)
#Linha 46 -> pegar esse conjunto e remover as stopwords
noticias_tokens <- tokens(noticias$texto,
                          remove_punct = TRUE,
                          remove_symbols = TRUE,
                          remove_numbers = TRUE,
                          remove_url = TRUE) |>
  tokens_remove(stopwords("pt")) |>
  tokens_wordstem(language = "portuguese")

matriz_frequencia <- dfm(noticias_tokens) #Matriz da frequência de palavras do texto

n <- round(0.8*nrow(noticias))
n
indices <- sample(1:nrow(noticias), size = n, replace = FALSE)

treino <- matriz_frequencia[indices,]
teste <- matriz_frequencia[-indices,]

modelo_nb <- textmodel_nb(treino, noticias$categorias[indices])

previsao <- predict(modelo_nb, newdata = teste)

mean(previsao == noticias$categorias[-indices])

#Em casa: tentar criar o proprio conjunto






