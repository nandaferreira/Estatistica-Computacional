dados <- read.table (file = "titanic.txt", sep = ",", header = TRUE)
summary(dados) #resumo do conjunto. É bom pra analisar se há necessidade de modificar algum tipo de dado ou não
dados <- dados[, -1] #exclui a primeira coluna 

sum(dados[,2])
dados[,2]

dados <- dados[,-c(1,12)]
summary(dados)
dados$Survived <- as.factor(dados$Survived) #transformando a variável em fator (ainda não entendi o que é esse fator)
summary(dados)
dados$Pclass <- as.factor(dados$Pclass)
dados$Sex <- as.factor(dados$Sex)
str(dados) #estrutura dos dados
?as.factor

dados[1,2]
dados[c(6,10),]

homens <- dados[dados$Sex == "male",] #ele compara entrada com entrada pra ver se é male. Vou guardar na variável "homem" quais os homens
summary(homens)
table(homens$Survived) #Saber quantos homens sobreviveram
barplot(table(homens$Survived))

mulheres <- dados[dados$Sex == "female",]
summary(mulheres)
table(mulheres$Survived) #Saber quantas mulheres sobreviveram
barplot(table(mulheres$Survived))

#Quantos homens que estavam na terceira classe morreram?
terceira_homens <- homens[homens$Pclass == 3,]
table(terceira_homens$Survived)

#-------------------------------------------------------------------------------------------------
#                                               REVISANDO
#-------------------------------------------------------------------------------------------------

#Para fazer a leitura de um arquivo ".txt" ou ".csv" no R:
# FUNÇÃO: "read.table"
# ESTRUTURA: read.table(file = "nome_do_arquivo.tipo", sep = ',', header = TRUE)
#o "sep" é pra especificar como as informações estão separadas/organizadas no arquivo base
# FUNÇÃO: "summary" -> faz um resumo das informações. é interessante pra ver se há necessidade de mudar alguma coisa ou não


