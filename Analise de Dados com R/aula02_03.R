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
hist(duracao$dias, breaks = 1000)

h<-hist(duracao$dias, plot=F, breaks = 1000)
h$counts <- (h$counts / sum(h$counts))*100
plot(h, freq=TRUE, ylab="Relative Frequency")

mean(duracao$dias, na.rm=TRUE)
median(duracao$dias, na.rm=T)
summary(duracao$dias)

sumario_media <- aggregate(duracao$dias, list(duracao$curso), mean, na.rm=TRUE)
sumario_mediana <- aggregate(duracao$dias, list(duracao$curso), median, na.rm=TRUE)

View(sumario_media)
sumario_media <- rename(sumario_media, replace=c('Group.1'='curso', 'x'='media'))

popularidade_duraca <- merge(sumario_media, sumario_mediana, by = intersect(names(sumario_media), names(sumario_mediana)), all = FALSE)