#revendo a aula anterior (parte de vetores)

a <- c(1,2,5)
b <- c(10,12)
d <- c(a,6) #concatena o vetor "a" com o vetor c(6)

3*a #multiplica todos os elementos do vetor
3+a #soma 3 a todos os elementos do vetor
d+b


#aprendendo a fazer laços com o R (for no R)

x <- 0
for(i in 1:20){
  x <- x+i
}
x
print(x)

#qual a probabilidade de duas pessoas de uma mesma turma fazerem aniversário no mesmo dia?

aniversarios <- sample(x = 1:365, size = 10, replace = TRUE)
aniversarios
duplicated(aniversarios)

resultados <- c() #vetor vazio que guarda os resultados das
for(j in 1:10000){
   aniversarios <- sample(x= 1:365, size = 10, replace = TRUE)
   resultados[j] <- any(duplicated(aniversarios)) #função "any" -> retorna os dias que forem iguais 
}
mean(resultados)

calcula_probabilidade <- function(n){
  resultados <- c ()
  for(j in 1:10000){
    aniversarios <-sample(x = 1:365, size = n, replace = TRUE)
    resultados[j] <- any(duplicated(aniversarios))
  }
  return(mean(resultados))
}
calcula_probabilidade (n=23)

#Problema da Mega Sena

bilhete <- c(50,22,12,43,21,34)
sorteio <- sample(x = 1:60, size = 6, replace = FALSE)
bilhete %in% sorteio

semanas <- 0
acertos <- 0

while(acertos < 4){
  sorteio <- sample(x = 1:60, size = 6, replace = FALSE)
  acertos <- sum(bilhete %in% sorteio)
  semanas <- semanas + 1
}
semanas/52
