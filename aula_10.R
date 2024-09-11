#Queremos analisar as taxas de alfabetização do país, por estado

install.packages("rvest")
library(rvest)
install.packages("dplyr")
library(dplyr) #pacote para manipular dados
library(ggplot2)

#Fazer a "raspagem" de dados de um site na internet
# 1 - obter a url da pagina
# 2 - jogar a url no R para pegar os dados
# 3- raspagem de elementos do html
# 4 -manipular esse conjunto de dados

url <- "https://pt.wikipedia.org/wiki/Lista_de_unidades_federativas_do_Brasil_por_alfabetiza%C3%A7%C3%A3o"
html <- read_html(url)
html

html_elements(html,"h1") #Encontrar tags do html: pega as tags de "h1" que são os parágrafos do site
html_text2(html_elements(html,"h1")) #Extraindo o texto entre os h1

html |> #pipe
  html_elements("h1") |>
  html_text2()

#raspar os dados
#pega de "table class" porque é onde tá os dados que vamos manipular
#pega o html e coloca ele no primeir

tabelas <- html |>
  html_elements("table") |> #vai ouxar todos os elementos tables da pagina
  html_table() #table transforma esse formato de HTML em tabela

alfabetizacao <- tabelas[[3]]

alfabetizacao <- alfabetizacao[,c(2,3)] #não tem nada antes da vírgula pq ele considera as duas dimensões da tabela (1 é a linha, 2 é a coluna). Nesse caso, como quero saber de todos o estados, eu considero tudo e, após, seleciono as colunas que me interessam (nesse caso a 2 e a 3)
names(alfabetizacao) <- c("estado", "taxa")
names(alfabetizacao)
library(stringr)

str_replace_all(string = "pedro145", patter = "\\d", replacement = "") #funcao(string, padrão, substituto)
#padrao = \\d porque eu quero tirar de várias strings, não só de 1. duas \\ porque ele ""escapa" a primeira. Vai escapar a primeira barra e continuar o dígito
#\d significa digito

parte1 <- str_replace_all(string = alfabetizacao$taxa, pattern =",", replacement = ".")
#Para esse vetor vou substituir o operador "%" por vazio

parte2 <- str_replace_all(string = parte1, pattern = "%", replacement = "")

parte_final <- as.numeric(parte2)
parte_final
parte_final <- parte_final/100

alfabetizacao$taxa <- parte_final

#Pegar os dados dos graficos, plotar no R
#Cada linha do meu conjunto vai ser o nome de um estado

install.packages("geobr")
library(geobr)

minas <- read_state(code_state = "MG")
library(ggplot2)

ggplot(data = minas) +
  geom_sf(fill = "darkred") +
  theme_void()

municipiomg <- read_municipality(code_muni = "MG")
ggplot(data = municipiomg)+
  geom_sf(fill = "#FF7F50")+
  theme_void()

estados <- read_state() #não passo nenhum especifico como parâmetro porque quero todos
estados$name_state
order(estados$name_state)
estados[2,] #extraimos o estado que esta na 2 posição de ordem alfabetica

estados <- estados[order(estados$name_state),] #ordenar a tabela pelos nomes em ordem alfabetica
estados

alfabetizacao <- alfabetizacao[order(alfabetizacao$estado),]
alfabetizacao

estados$taxa <- alfabetizacao$taxa #cria uma coluna de taxa dentro de "estados", atribuindo as taxas de "alfabetizacao"

ggplot(data = estados, aes(fill = taxa))+
  geom_sf()+
  scale_fill_gradient(high = "#132B43", low = "#56B1F7")

?scale_fill_gradient

