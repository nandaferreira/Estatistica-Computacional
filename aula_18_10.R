#Lancar um dado 500 vezes, calcular a media, e fazer esse experimento 1000 vezes e guardar essas 1000 vezes. Depois fazer o histograma

media <- mean(sample(1:6, size = 500, replace = TRUE))
media

resultados <- c()

for (j in 1:1000){
  resultados[j] <- mean(sample(1:6, size = 500, replace = TRUE))
}

hist(resultados)

dados <- data.frame(resultados) #transformei num data frame para conseguir plotar o grafico
library(ggplot2)

ggplot(data = dados, mapping = aes(x = resultados))+
  geom_density(fill = "#a1d99b")+
  theme_minimal()
#------------------------------------------------------------------------------------------
# p = proporção de pessoas com diabete (exemplo) 
# Xi = cada pessoa da população
#Xi só assume dois valores = 1 se tem a doença | 0 não tem a doença

#Criar a população fictícia, calcular a proporção baseando-se no experimento aleatório
#10% com diabetes

populacao <- sample(x = 0:1, size = 100000, replace = TRUE, prob = c(0.9,0.1))
valor_real <- mean(populacao)

amostra <- sample(populacao, size = 500, replace = TRUE)
media <- mean(amostra)
media

#ainda não entendi o que seriam essas partes "inferior" e "superior" do intervalo

parte_inferior <- media - 1.96*(sqrt(media*(1-media))/sqrt(500))
parte_superior <- media + 1.96*(sqrt(media*(1-media))/sqrt(500))

#Criar um vetor que vai conter as partes inferiores e outro que contém as partes superiores

inferiores <-c()
superiores <-c()

for(k in 1:100){
  amostra <- sample(populacao, size = 500, replace = TRUE)
  media <- mean(amostra)
  inferiores[k] <- media - 1.96*(sqrt(media *(1-media))/sqrt(500))
  superiores[k] <- media + 1.96*(sqrt(media*(1-media))/sqrt(500))
}
inferiores[24]
superiores[24]

intervalos <- data.frame(inferiores, superiores, contador = 1:100)
ggplot(data = intervalos)+
  geom_segment(aes(x = inferiores, xend = superiores, y = contador, yend = contador, col = categoria))+
  geom_vline(xintercept = valor_real, col = "yellow")

#if else junto achei cabuloso
#se algum desses der true é porque eu errei (??)
categoria <- ifelse((intervalos$inferiores) > valor_real | intervalos$superiores < valor_real,0,1)

intervalos$categoria <- as.factor(categoria)
