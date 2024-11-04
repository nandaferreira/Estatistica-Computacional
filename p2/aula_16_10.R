library(ggplot2)

grilo <- read.table(file = "grilo.txt", header = TRUE, sep = ",")

str(grilo)

ggplot(data = grilo, aes(x = frequencia)) + geom_histogram(bins = 10, fill = "lightblue", col = "darkblue") + theme_dark()

ggplot(data = grilo, aes(x = temperatura, y = frequencia, col = frequencia)) + geom_point() + theme_dark() + geom_smooth(method = "lm", color = "lightyellow")

linear_model <- lm(formula = frequencia ~ temperatura, data = grilo)

print(linear_model)
summary(grilo$temperatura)

plot <- data.frame(temperatura = c(21, 23.6, 30.9))

predict(linear_model, newdata = plot)


#penguins

library(palmerpenguins)
library(dplyr)

pinguins <- penguins
pinguins <- na.omit(pinguins)

summary(pinguins)
str(pinguins)

pinguins$species <- as.factor(pinguins$species)
pinguins$island <- as.factor(pinguins$island)
pinguins$year <- as.factor(pinguins$year)
pinguins$sex <- as.factor(pinguins$sex)

cor(pinguins[, 3:6])

ggplot(data = pinguins, aes(x = flipper_length_mm, y = body_mass_g, col = species)) + geom_point(fill = black) + geom_smooth(method = "lm")

pinguins |> 
  filter(species == "Gentoo") |>
  select(flipper_length_mm, body_mass_g) |>
  cor()

pinguins |> 
  filter(species == "Chinstrap") |>
  select(flipper_length_mm, body_mass_g) |>
  cor()

pinguins |> 
  filter(species == "Adelie") |>
  select(flipper_length_mm, body_mass_g) |>
  cor()

snLinear_model <- lm(formula = flipper_length_mm ~ body_mass_g + bill_length_mm, data = pinguins)

print(snLinear_model)

summary(snLinear_model)
