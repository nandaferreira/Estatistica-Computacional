library(palmerpenguins)
library(ggplot2)

data(penguins)
pinguins <- penguins
str(pinguins)

#excluir as variaveis "sexo" e "ano"
#so quero as variaveis resposta e numericas

pinguins <- pinguins[,-c(2,7,8)]
pinguins <- na.omit(pinguins) #tirar os valores nao disponiveis da análise

n <- round(0.8*nrow(pinguins)) #pega os 80%
n
indices_treino <- sample(1:nrow(pinguins), size = n, replace = FALSE)

#treinamento: olho para o conjunto todo

treino <- pinguins[indices_treino,]
teste <- pinguins[-indices_treino,]

treino_padronizado <-scale(treino[,-1]) #tirei a espécie porque quero padronizar os dados.
teste_padronizado <-scale(teste[,-1])

classe_treino <- treino$species #cl
clsse_teste <- teste$species

#quero prever qual a especie do pinguin

modelo1 <- knn(train = treino_padronizado, test = teste_padronizado, cl = classe_treino, k = 1)
mean(modelo1 == teste$species)

modelo2 <- knn(train = treino_padronizado, test = teste_padronizado, cl = classe_treino, k = 20)
mean(modelo2 == teste$species)

#Fazer com os dois tamanhos do bico e os dois tamanhos do peso

cor(treino[,-1])

taxa_acerto <- c()

for(k in 1:10){
  modelo <- knn(train = treino_padronizado, test = teste_padronizado, cl = classe_treino, k = k) #respostas do teste baseadas no treino
  taxa_acerto[k] <- mean(modelo == teste$species)
}

df <- data.frame(k = 1:10, taxa_acerto)
ggplot(data = df, aes(x = k, y = taxa_acerto)) +
  geom_line()

df
#**PROVA - Validação Cruzada


