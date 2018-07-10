install.packages("readr")
library(readr)

duracao <- read_csv('/home/laumzav/PycharmProjects/Rstudy/Analise de Dados com R/duracao.csv')
View(duracao)

install.packages("plyr")
library(plyr)
duracao <- rename(duracao, replace=c('user_id'='aluno', 'course_id'='curso', 'timeToFinish' = 'dias'))
View(duracao)

plot(duracao$dias)
mean(duracao$dias)

hist(duracao$dias)
h <- hist(duracao$dias, breaks = 1000)
plot(h, freq=True)

h<-hist(duracao$dias, plot=F, breaks = 1000)
h$counts <- (h$counts / sum(h$counts))*100
plot(h, freq=TRUE, ylab="Relative Frequency")