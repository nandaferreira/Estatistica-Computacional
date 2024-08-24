iris
iris <- iris[sample(), (nrow(iris)),]
iris
n <- round(0.8*nrow(iris)) #pegando 80% do número de linhas
n

treinamento <- iris[1:n,] 
teste <- iris[-(1:n)]

ggplot(data = treinamento, aes(x = Petal.Length, y = Petal.Width, col = Species))+
  geom_point(size = 2, alpha = 0.5)+
  theme_minimal()
#---------------------------------------------------------------------------------------------------
#Criar um modelo que seja capaz de dizer qual a espécie da flor
#Treinamento dos modelos: identificar os padrões de cada espécie para conseguir traduzir isso nos testes

library(ggplot2)
#passo 1 - Dividir em treino e teste

set.seed(1711) #
iris <- iris[sample(nrow(iris)),] #nrow retorna o número de linhas; ncolum retona o número de colunas
n <- round(0.8*nrow(iris)) #round arredonda o número pra certificar que não vai dar um número quebrado.Nesse caso quero 80%

treino <- iris[1:n,] #1:n é a dimensão das linhas. Tô falando pra ele que quero ler da posição 1 até n
teste <- iris[-(1:n),] #se eu tiro isso sobrará os outros 20% que tô querendo

#quantas espécies de cada uma das flores tem dentro de treino?

ggplot(data = treino, mapping = aes(x = Species)) + 
  geom_bar()

ggplot(data = treino, mapping = aes(x = Petal.Length))+
  geom_histogram(bins = 20, fill = "pink")
#não faz sentido fazer um gráfico de barras aqui porque tenho números contínuos. Por isso o histograma (ou boxplot)

ggplot(data = treino, mapping = aes(y = Petal.Length)) +
  geom_boxplot() +
  facet_wrap(~Species)
#Qualquer comprimento das outras duas espécies é maior do que o máximo da setosa (então já posso separar dizendo que ela tem o menor tamanho de pétala)

ggplot(data = treino, mapping = aes(y = Sepal.Length))+
  geom_boxplot()

ggplot(data = treino, mapping = aes(y = Sepal.Width))+
  geom_boxplot()+
  facet_wrap(~Species)


ggplot(data = treino, mapping = aes(x = Petal.Length, y = Petal.Width, color = Species))+
  geom_point()

#teste [1,5]

x <- 10
if(x <20){
  print("numero menor do que 20")
}else{
  print("maior ou igual a 20")
}

resultados <- c() #sempre criar o vetor vazio primeiro
for(j in 1:nrow(teste)){
  if(teste$Petal.Length[j] < 2.5){
    resultados[j] <- "setosa"
  }else{
    if(teste$Petal.Width[j] < 1.75){
      resultados[j] <- "versicolor"
    }else{
      resultados[j] <- "virginica"
    }
  }
}
