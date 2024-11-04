install.packages("Stat2Data")
library(Stat2Data)
library(ggplot2)

populacao <- sample(x = 0:1, size = 100000, replace = TRUE, prob = c(0.88, 0.12))

amostra <- sample(populacao, size = 200, replace = TRUE)

mean(amostra)

prop.test(x = sum(amostra == 1), n = 200, p = 0.1, alternative = "two.sided")

ostras <- data(Oysters)

ostras <- Oysters[, -1]

ggplot(data = ostras, aes(x = TwoD, y = Volume)) + geom_point() + geom_smooth(method = lm)

cor(ostras$TwoD, ostras$Volume) #coreelação alta

cor.test(ostras$TwoD, ostras$Volume)

LinearModel <- lm(formula = Volume ~ TwoD, data = ostras)

print(LinearModel)

summary(LinearModel)

LinearModel$residuals
hist(LinearModel$residuals)

shapiro.test(LinearModel$residuals)
