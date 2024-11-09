#o objetivo desse trabalho é utilizar o método de clusterização K-means para identificar espécies de baleias;

#considere o conjunto das baleias, mas "esqueça" a espécie de cada uma delas; queremos utilizar um método não supervisionado para agrupar as baleias em grupos de acordo com suas características; lembre-se que o K-means é um método de clusterização que agrupa os dados em K grupos, de acordo com a distância entre os pontos; por considerar a distância entre os pontos, o K-means é um método sensível à escala dos dados, então é importante padronizar os dados antes de aplicar o método;

baleias <- read.table("baleias.txt", header=TRUE, sep = ",")
str(baleias)

baleias_padronizado <- scale(baleias[,-1])

modelo_kmeans <- kmeans(baleias_padronizado, centers = 4, nstart = 10)

#após a clusterização, podemos visualizar os grupos formados e a que grupo cada baleia pertence:
aglomerados <- modelo_kmeans$cluster
baleias$aglomerado <- aglomerados

#vamos analisar as baleias que estão no grupo 1 e verificar no conjunto a quais espécies elas pertencem:

baleias |>
  filter(aglomerado == 1) |>
  ggplot(aes(x = especie)) +
  geom_bar()

#vamos analisar as baleias que estão no grupo 2:
baleias |>
  filter(aglomerado == 2) |>
  ggplot(aes(x = especie)) +
  geom_bar()

#grupo 3
baleias |>
  filter(aglomerado == 3) |>
  ggplot(aes(x = especie)) +
  geom_bar()

#grupo 4
baleias |>
  filter(aglomerado == 4) |>
  ggplot(aes(x = especie)) +
  geom_bar()
