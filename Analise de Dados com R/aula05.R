# importar dados da aula04

plot(popularidade_duracao$frequencia, popularidade_duracao$mediana)
modelo.linear <- lm(popularidade_duracao$mediana ~ popularidade_duracao$frequencia)
abline(modelo.linear, col='red')
summary(modelo.linear)

install.packages("ggplot2")
library("ggplot2")

grafico <- ggplot(popularidade_duracao, aes(frequencia, media)) +
        geom_point() +
        geom_smooth()

grafico