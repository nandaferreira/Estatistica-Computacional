#importe o arquivo femur.csv
#crie um conjunto apenas com os homens
#calcule o coeficiente de correlacao entre altura e femur
#determine a reta de regressao linear
library(dplyr)
library(ggplot2)

femur <- read.csv("femur.csv")
str(femur)

#PASSO 1: analisar a correlacao

homens <- femur |>
  filter(genero == "Male")
str(homens)
cor(homens$altura, homens$femur)
ggplot(data = homens, aes(x = femur, y = altura))+
  geom_point()
#visualmente, parece que há uma correlacao positiva entre altura e femur para os homens

#cor.test: teste de hipoteses para verificar se o coefiiente de correlacao é zero

#H0: coeficiente de correlacao é zero
#Ha: coeficiente de correlacao não é zero

cor.test(homens$altura, homens$femur)
#como o p-valor < 0.05, rejeitamos a hipotese nula e concluimos que há correlacao entre altura e femur

#PASSO 2: vamos determinar a reta de regressao

modelo <- lm(data = homens, formula = altura ~ femur)
modelo

summary(modelo)
#a partir do resumo do modelo, percebemos que os coeficientes são significativos, ou seja, isto é, os coefientes são diferentes de zero; esta análise é feita a partir daquelas estrelinhas que aparecem ao lado dos coeficientes; 3 estrelinhas significa que o p-valor do teste de hipoteses para o coeficiente é menor que 0.001; neste teste, a hipotese nula é que o coeficiente é zero e a hipotese alternativa é que o coeficiente é diferente de zero; se o p-valor for menor que 0.05, rejeitamos a hipotese nula e concluimos que o coeficiente é diferente de zero; neste caso, os dois coeficientes foram testados e são diferentes de zero e o modelo considerado será: altura = 2.61*femur + 44.20

#PASSO 3: ANALISAR OS RESIDUOS (ISTO É, ANALISAR OS ERROS)
#precisamos verificar se os residuos seguem uma distribuicao normal

#vamos realizar um teste de hipoteses para verificar se os residuos seguem uma distribuicao normal

#H0: os residuos seguem uma distribuicao normal
#Ha: os residuos não seguem uma distribuicao normal

shapiro.test(modelo$residuals) 
#como o p-valor > 0.05, não rejeitamos a hipotese nula;

#como não rejeitamos a hipotese nula, vamos considerar, por enquanto, que os residuos seguem uma distribuicao normal e por isso o modelo ajustado é válido e poderia ser utilizado para fazer previsoes, por exemplo.

#para um valor de femur = 50, qual seria a altura prevista?
#altura = 2.61*50 + 44.20 = 174.70

#para um valor de femur = 60, qual seria a altura prevista?
#neste caso, o modelo não pode ser utilizado para prever a altura, pois o valor de femur está fora do intervalo de valores observados para femurno conjunto considerado; neste caso, estaríamos extrapolando o modelo, o que não é recomendado.


#Adendo meu: Por que a normalidade dos resíduos é importante?
#Na regressão linear, a suposição de normalidade dos resíduos ajuda a garantir que os intervalos de 
#confiança e testes de hipótese para os coeficientes do modelo são válidos. Se os resíduos não forem 
#normalmente distribuídos, isso pode indicar problemas no ajuste do modelo e afetar a confiabilidade 
#das previsões.