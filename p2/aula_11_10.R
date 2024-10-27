#Regressão linear 
#Correlação é uma relação entre duas variáveis. Os dados podem ser representados por pares ordenados(x,y). X sendo a variável independente ou explanatória; Y a variável dependente ou resposta
#Correlação linear negativa | Correlação linear positiva | Não há correlação | Correlação não linear
#Coeficiente de correlação -> medida da força e da direção de uma relação linear entre duas variáveis. O símbolo r represne
#Quanto mais perto de 1 em módulo mais perto 
# ---------------------------------------------------------------------------------------------------
data(iris)
library(ggplot2)

ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width))+
  geom_point(color = "purple")+
  theme_minimal()

cor(iris$Petal.Length, iris$Petal.Width)
#O resultado vai ser sempre 1 e -1; Quanto mais proximo do 1 mais certeiro e positivo é o resultado. Quanto mais próximo de -1 mais certeiro e negativo será o resultado

cor(iris[,-5])
#Calcular relação da setosa, versicolor

setosa <- c()
setosa <- iris[iris$Species == "setosa",] #pegar apenas os setosas
cor(setosa$Sepal.Length, setosa$Petal.Width)
ggplot(data = setosa, aes(x = Petal.Length, y = Petal.Width))+
  geom_point(color = "#31a354")+
  theme_minimal()

versicolor <- c()
versicolor <- iris[iris$Species == "versicolor",]
cor(versicolor$Sepal.Length, versicolor$Petal.Width) #"cor" é a função que retorna a correlação entre duas variáveis
ggplot(data = versicolor, aes(x = Petal.Length, y = Petal.Width))+
  geom_point(color = "#fc9272")+
  theme_minimal()

virginia <-c()
virginia <- iris[iris$Species == "virginia",]
cor(virginia$Sepal.Length, virginia$Petal.Width)
ggplot(data = virginia, aes(x = Petal.Length, y = Petal.Width))+
  geom_point(color = "#fa9fb5")+
  theme_minimal()
#-----------------------------------------------------------------
#Trabalhando com o conjuntos de dados femur

femur <- read.csv(file = "femur.csv", header = TRUE)
str(femur)
femur$genero <- as.factor(femur$genero)
homem <- femur[femur$genero == "Male",]
mulher <- femur[femur$genero == "Female",]
femur <- femur[,-1]

cor(x = homem$altura, y = homem$femur) #correlação entre a altura dos homens e sua altura
mean(homem$altura) #média altura homens

cor(x = mulher$altura, y = mulher$femur) # correlação entre a altura das mulheres e sua altura
mean(mulher$altura) #média altura mulheres

ggplot(data = homem, aes(x = femur, y = altura))+
  geom_point(color = "#2c7fb8")+
  theme_minimal()

ggplot(data = mulher, aes(x = femur, y = altura))+
  geom_point(color = "#7fcdbb")+
  theme_minimal()

modeloLinear <- lm(data = homem, formula = altura ~ femur)
summary(homem$femur) #com isso eu sei que uma reta é válida dentro do intevarlo entre o valor mínimo e o máximo do modelo, fora disso não
