install.packages("ggplot2")
library(ggplot2) #

titanic <- read.table(file = "titanic.txt", sep = ",", header = TRUE)
titanic
titanic <- titanic[,-c(1,9:12)] #quero excluir a linha 1 e de 9 a 12 (por isso o ":", porque é sequencial, então concateno os vetores que eu quero tirar) 
str(titanic)
titanic$Survived <- as.factor(titanic$Survived)
summary(titanic$Survived)

titanic$Pclass <- as.factor(titanic$Pclass) #transformar em fator (pode ser me número, string, conforme a demanda)

#os "fatores" também podem ser chamados de "varíaveis categóricas". Essas variáveis geralmente tem uma quantidade limitada de atribuições.
# sexo, por exemplo, tem feminino e masculino. O as.factor pega o que seria o "femino" e o "masculino", em character, e transforma em um fator (categoria)
#também pode funcionar para o exemplo da nacionalidade
#é melhor transformar em fator porque quando você pede um "summary" ele retorna quais as opções aquela categoria possui

titanic$Sex <- as.factor(titanic$Sex)
str(titanic)

summary(titanic)

#ggplot(data = titanic, aes(x = Survived, fill = Sex))+ 
 # geom_bar() + 
  #scale_fill_manual(values = c("male" = "#9ebcda", "female" ="#8856a7")) 
  #theme_classic()
#primeiro o nome do arquivo, segundo a parte estética (pega a variável e leva para outro eixo), tipo de grafico (++),
#mapeia o sexo no eixo x e preencher as barras com Survived
  
ggplot(data = titanic, aes(x = Sex, fill = Survived))+
  geom_bar() +
  labs(title = "Análise de sobrevivência de homens e mulheres por classe", x = "Sexo", y = "Frequência", fill = "Sobreviveu")+
  scale_fill_manual(values = c("0" = "#e34a33", "1" = "#fdbb84"),labels = c("0" = "não", "1" = "sim"))+
  facet_wrap(~Pclass) +
  scale_x_discrete(labels = c("female" = "mulher", "male" = "homem"))
  theme_classic
  
#------------------------------------------------------------------------------------------

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
