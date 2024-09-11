library(rpart)
library(rpart.plot)

dados <- read.csv("cancer.csv", sep = ',', header = TRUE)
dados

n <- round(0.8*nrow(dados)) #pega os 80%
n
indices_treino <- sample(1:nrow(dados), size = n, replace = FALSE)

treino <- dados[indices_treino,]
teste <- dados[-indices_treino,]

treino_padronizado <- scale(treino[,-1])
teste_padronizado <-scale(teste[,-1])

classe_treino <- treino$diagnosis
classe_teste <- teste$diagnosis

#------------------------ Modelo Floresta Aleatória------------------------------------------------------------------------------------------

# Nessa aula serão feitos os mesmos teste da aula anterior, agora utilizando outro modelo (árvore de decisão)
#Ele vai pegar o vetor e ordenar do maior para o menor
#Descobrir a pureza da árvore. A que tiver a maior pureza será onde começará

#Formula: falar qual variavel eu quero modelar (nesse caso é "diasnosis"). Nesse caso quero o diagnóstico de quem tem a doença ou não
#Ponto (.): significa que vai pegar todas as coisas
#(~): Está em função de (nesse caso de todo mundo - diagnóstico)
#Data = conjunto que eu estou analisando (nesse caso "treino")
#Metodo = class (classfication)
#Extra = 101 :

modelo.arvore <- rpart(formula = diagnosis~ ., data = treino, method = "class")

rpart.plot(modelo.arvore, extra = 101)

#Para prever os diagnosticos dos testes. Recebe como parâmetro (modeloDaArvore, conjunto que eu quero editar, tipo de classificação )

previsao <- predict(modelo.arvore, newdata = teste, type = "class")
