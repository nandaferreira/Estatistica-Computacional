#Prova -> Até os 3 modelos de árvore

#Bootstrap -> "amostra da amostra"
install.packages("randomForest")
#fazer com que as árvores sejam independentes uma da outra
#conseguimos construir vários conjuntos de treinamento a partir de um
#default: 500

library(rpart)
library(rpart.plot)

dados <- read.csv("cancer.csv", sep = ',', header = TRUE)
dados
str(dados)
dados$diagnosis <- as.factor(dados$diagnosis)

n <- round(0.8*nrow(dados)) #pega os 80%
n
set.seed(1731)

indices_treino <- sample(1:nrow(dados), size = n, replace = FALSE)

treino <- dados[indices_treino,]
teste <- dados[-indices_treino,]

#

arvore <- rpart(formula = diagnosis ~ ., data = treino, method = "class")
previsao.arvore <- predict(arvore, newdata = teste, type = "class")
mean(previsao.arvore == teste$diagnosis)

floresta <- randomForest(formula = diagnosis ~ ., data = treino, ntree = 200)
floresta


