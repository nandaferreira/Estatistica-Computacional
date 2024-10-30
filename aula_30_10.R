#importe o arquivo femur.csv
#crie um conjunto apenas com os homens
#calcule o coeficiente de correlação entre altura e femur
#determine a reta de regressao linear

library(dplyr)
library(ggplot2)

femur <- read.csv("femur.csv")
str(femur)

#Passo 1 -> analisar o coeficiente de correlação


homens <- femur |>
  filter(genero == "Male")
str(homens)
cor(homens$altura, homens$femur) #correlação
ggplot(data = homens, aes(x = femur, y = altura))+
  geom_point()+ #por que nesse caso é melhor usar o gráfico de pontos?
  geom_smooth(method = "lm")+
  theme_minimal()

#cor.teste: faz o teste de hipóteses para verificar se o coeficiente de correlação é 0 (pra que?)
#H0: coeficiente de corr. é zero
#Ha: coeficiente de corre. não é zero

cor.test(homens$altura, homens$femur) #quanto menor for o valor, mais rejeitarei a hipotese (o que significa ser pequeno? nesse caso ser menor que 5%)

#Passo 2 -> determinar a reta de regressão e verificar se é um bom modelo

modelo <- lm(data = homens, formula = altura ~ femur)
modelo 
summary(modelo) #call = chamado da função (altura em função do femur, a partir do conjunto homens)
#residuals: cria essa reta de regressão, joga o valor da altura do femur dentro dessa reta. Mostra a distribuição dos resíduos(resumo estatistico)
#Coeficientes: valores estimados (*** -> teste de hipotese: testa se o coeficiente é diferente de 0 ou não)em 
#Nesse caso quero rejeitar as hipoteses nulas (ai depende do problema)

#Passo 3 -> Analisar os rsiduos (analisar os erros)

hist(modelo$residuals)

#histograma não é suficiente, tem que fazer outro teste de hipótese

#realizar um teste de hipotese para verificar se os resíduos seguem uma distribuição normal
#H0: os residuos seguem uma distribuição normal
#Ha: os residuos nao seguem uma distribuição normal

shapiro.test(modelo$residuals)
