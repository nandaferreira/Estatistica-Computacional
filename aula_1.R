#Operações

#O R funciona como uma calculadora

2+5 #soma
3-6 #subtração
3*3 #multiplicação
40/5 #divisão
3**2 #potenciação
10%%3 #resto da divisão

#atribuindo valores

a <- 3*2

class(d)
class(1)

d <- TRUE
class(d)

d + a
FALSE + a

#true vale 1
#false vale 0

TRUE + TRUE
FALSE + FALSE
TRUE + FALSE/FALSE
TRUE/FALSE

v1 <- 4+3
V1 <- 3+90

x <- "teste"
class(x)
x

#criando vetores

x1 <- c(3,10,78)
x1[2]
length(x1)
sum(x1)
mean(x1)


c(1,6, "teste") #tenho que guardar esse vetor em algum lugar
x1[c(2,3,2,1)] #não entendi o que essa linha faz com x1
x2 <- c(x1, 67, 90)
x2 < 70
sum(x2 < 70)
x2[x2 < 70] #filtro lógico para extrair o que eu quero do vetor

x2 > 54
x2 == 10
x2 != 10

!TRUE
TRUE | FALSE #ou
TRUE & FALSE #e

sample #função de sortear

dado <- sample(x = 1:6, size = 100, replace = TRUE)
dado
sum(dado == 3)
mean(dado == 3)
table(dado)
barplot(table(dado))
?table
#-------------------------------------------------------------------------------------------------
#                                               REVISANDO
#-------------------------------------------------------------------------------------------------

# dados <- sample(x = 1:6, size = 1000000, replace = TRUE) 
# dados: nome da variavel que recebe o experimento
# <- simbolo de atribuição
# x = 1:6 é a "proporção". nesse caso significa que o sorteio será de 1 em 1, com números de 1 até 6
# size vai dizer quantas vezes você quer repetir o mesmo experimento
# replace indica se haverá ou não reposição dos números ou não (TRUE = repõe; FALSE = não repõe)

#table vai me mostrar quantos valores tem em cada uma das dimensões (colunas)
# nesse caso: 1 tem 13 elementos, 2 tem 20, 3 tem 14, 4 tem 19, 5 tem 20, 6 tem 14





