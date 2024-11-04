#Aprendizado não-supervisionado

install.packages("jpeg")
library(jpeg)
library(ggplot2)
gatinho <- readJPEG("batatinha.jpg")
str(gatinho)

R <- as.vector(gatinho[,,1])
G <- as.vector(gatinho[,,2])
B <- as.vector(gatinho[,,3])

x <- rep(1:3164, each = 4430)
x
y <- rep(4430:1, times = 3164)

dados <- data.frame(x,y,R,G,B)
head(dados)
?kmeans

clusterizacao <- kmeans(x = dados[,3:5], centers = 3, nstart = 20)
clusterizacao$centers
rgb(clusterizacao$centers)
cluster <- as.factor(clusterizacao$cluster)
dados$cluster <- cluster
head(dados)

ggplot(data = dados, aes(x = x, y = y, col = cluster))+
  geom_point()+
  scale_color_manual(values = cores)+
  theme_void
