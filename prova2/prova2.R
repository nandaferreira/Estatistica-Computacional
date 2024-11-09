#----------Questão 1------------

library(ggplot2)
peixes <- read.table(file = "peixe_boi.txt", header = TRUE, sep = ";")
str(peixes)
#-------(a)-----
ggplot(peixes, aes(x = barcos, y = mortes, color = mortes)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "black")+ #reta de regressão
  labs(title = "Número de mortes de peixes-boi em função do número de lanchas", x = "Número de barcos", y = "Mortes peixes boi") +
  theme_minimal()

#A partir do gráfico analisado pode-se afirmar que quanto maior for o número de lanchas, 
#maior o número de mortes de peixes-boi serão registrados.

#--------(b)-----

cor(peixes$mortes, peixes$barcos) 
#A função cor calcula o coeficiente de relação entre o número de mortes e barcos, diferentemente da cor.test que vai 
#retornar o nível de significância da correlação. A partir do valor que obtivemos, podemos afirmar que há uma forte correlação 
#entre as variáveis "mortes" e "barcos".

#-----(c)-----

modelo <- lm(data = peixes, formula = mortes ~ barcos)
modelo
summary(modelo)
#De acordo com a análise da função summary, nesse caso, podemos concluir que o coeficiente não é nulo, pois o símbolo (***) 
#representa um valor menor que 0.001, que também é menor que 0.05 (com p-value igual a 2.2e-16). 

#-----(d)----
#H0: os residuos seguem uma distribuicao normal
#Ha: os residuos não seguem uma distribuicao normal

shapiro.test(modelo$residuals)

#p-value é igual a 0.9458, ou seja, como o p-value é um valor maior que 0.05, então NÃO rejeitamos a 
#hipótese de ser nula e, por isso também, vamos considerar que os resíduos seguem uma distribuição normal.
#Sendo assim vamos usar esse modelo para podermos fazer nossas previsões.


#-----(e)----

#Para um valor de barco = 800.000 em um determinado ano, qual seria o número de mortes de peixes-boi?
#numero de barcos* 0.1322 - 44.7218 = 

previsao <- 800*0.1322 - 44.7218 

#Podemos confiar nessa previsão, pois a fórmula que obtivemos foi baseada nos intervalos do nosso modelo linear.
#Como os resíduos seguem uma distribuição normal, o modelo é considerado confiável, portanto, essa previsão também será.


#----(f)-----
#Para numero de barcos = 200
#Como o intervalo que temos é de aproximadamente 400 a 1100, não é possível fazer uma previsão correta a partir da fórmula que 
#obtivemos anteriormente, para um número de barcos = 200 pois este não está dentro do nosso intervalo. 


#-----Questão 2-----

#Questão 2

library(ggplot2)
musicas <- read.table("musicas.txt", header=TRUE, sep = ";")
str(musicas)


#padronizando
musicas_p <- scale(musicas[, 1:6])

musicas_p

modelo_kmeans <- kmeans(musicas_p, centers = 3, nstart = 10)

aglomerados <- modelo_kmeans$cluster
musicas_p$aglomerado <- aglomerados
musicas_p

musicas$aglomerado <- factor(modelo_kmeans$cluster)
head(musicas)


ggplot(musicas, aes(x = aglomerado, fill = artista)) +
  geom_bar(color = "black") +
  labs(x = "Aglomerado", y = "Contagem", fill = "Artista") +
  theme_minimal()

# O grafico esta separado em três clusters (agloremados). No aglomerado 1 temos apenas musicas 
#dos raconais MCS,no aglomerado 2 temos apenas musicas da banda Pato Fu, e no 3, musicas dos
#3 artistas, sendo predominante as musicas do Cartola Podemos observar, por exemplo, 
#que os temas das letras de Pato Fu e de racionais MC´S estao mais distantes uns dos outros. 
#Apesar disso, há músicas relacionadas, já que os dois aparecem no aglomerado 3. 
#Ja em relação ao Cartola, que aparece apenas no aglomerado 3, pode-se perceber que as letras 
# dele diferem muito das letras das bandas, por esse padrão, pode-se dizer que algumas poucas 
#letras das bandas é que têm temas parecidos com as do Cartola, e não o contrário.

