#vamos utilizar este conjunto das baleias para revisar alguns dos modelos de classificação que estudamos no curso

library(ggplot2)
library(rpart)
library(rpart.plot)
library(randomForest)
library(dplyr)
library(class)


baleias <- read.table("baleias.txt", header=TRUE, sep = ",")
str(baleias)

#este conjunto apresenta informações sobre algumas espécies de baleias, como comprimento, peso, volume do crânio e profundidade máxima; existe uma variável categórica e as demais são numéricas;

baleias$especie <- as.factor(baleias$especie)

#como consideraremos modelos de classificação, dividiremos o conjunto em treino e teste

set.seed(123)
indices_treino <- sample(1:nrow(baleias), 0.75*nrow(baleias))
treino <- baleias[indices_treino,]
teste <- baleias[-indices_treino,]

#agora, analisaremos o conjunto de treino para compreendermos melhor as variáveis

ggplot(data = treino, aes(x =especie)) +
  geom_bar() +
  theme_minimal()+
  labs(x = "espécie",
       y = "frequência")

#percebe-se que a espécie Azul possui mais registros que as demais e que a espécie Jubarte possui menos registros;

#vamos analisar agora, como se dá a distribuição do peso dentro de cada espécie

treino |>
  filter(especie == "Baleia Azul") |>
  ggplot() +
   geom_histogram(aes(x = peso), bins = 10) +
   theme_minimal()

treino |>
  filter(especie == "Baleia Fin") |>
  ggplot() +
  geom_histogram(aes(x = peso), bins = 10) +
  theme_minimal()

treino |>
  filter(especie == "Cachalote") |>
  ggplot() +
  geom_histogram(aes(x = peso), bins = 10) +
  theme_minimal()

treino |>
  filter(especie == "Jubarte") |>
  ggplot() +
  geom_histogram(aes(x = peso), bins = 10) +
  theme_minimal()

#podemos fazer isso para as outras variáveis também;

#podemos fazer este mesmo estudo a partir de boxplots considerando todas as espécies de uma vez;

ggplot(data = treino, aes(x = especie, y = peso)) +
  geom_boxplot() +
  theme_minimal()

ggplot(data = treino, aes(x = especie, y = profundidade_maxima)) +
  geom_boxplot() +
  theme_minimal()


#gráficos de dispersão também podem ser considerados para analisar a relação entre duas variáveis;

ggplot(data = treino, aes(x = peso, y = comprimento, color = especie)) +
  geom_point() +
  theme_minimal() +
  theme(legend.position = "bottom")

#criando um modelo KNN
treino_padronizado <- scale(treino[,-1])
teste_padronizado <- scale(teste[,-1])

#criando um modelo KNN com k = 1
modelo_knn1 <- knn(train = treino_padronizado, test = teste_padronizado, cl = treino$especie, k = 1)
table(modelo_knn1, teste$especie)
mean(modelo_knn1 == teste$especie) #acuracia

#criando um modelo KNN com k = 3
modelo_knn3 <- knn(train = treino_padronizado, test = teste_padronizado, cl = treino$especie, k = 3)
table(modelo_knn3, teste$especie)
mean(modelo_knn3 == teste$especie) #acuracia

#criando uma árvore de decisão
modelo_arvore <- rpart(especie ~ ., data = treino, method = "class")
rpart.plot(modelo_arvore, extra = 101)
previsao_arvore <- predict(modelo_arvore, newdata = teste, type = "class")
table(previsao_arvore, teste$especie)
mean(previsao_arvore == teste$especie) #acuracia

#criando um modelo de floresta aleatória
modelo_floresta <- randomForest(especie ~ ., data = treino)
previsao_floresta <- predict(modelo_floresta, newdata = teste)
table(previsao_floresta, teste$especie)
mean(previsao_floresta == teste$especie) #acuracia
