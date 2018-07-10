setwd('/home/laumzav/PycharmProjects/Rstudy/Analise de Dados com R/')

library(readr)
populariade <- read_csv('popularidade.csv')
duracao <- read_csv('duracao.csv')

library(plyr)
duracao <- rename(duracao, replace=c('user_id'='aluno', 'course_id'='curso', 'timeToFinish' = 'dias'))

sumario_media <- aggregate(duracao$dias, list(duracao$curso), mean, na.rm=TRUE)
sumario_mediana <- aggregate(duracao$dias, list(duracao$curso), median, na.rm=TRUE)

sumario_media <- rename(sumario_media, replace=c('Group.1'='curso', 'x'='media'))
sumario_mediana <- rename(sumario_mediana, replace=c('Group.1'='curso', 'x'='mediana'))
head(sumario_mediana)

popularidade_duracao <- merge(sumario_media, populariade, by = intersect(names(sumario_media), names(populariade)), all = FALSE)
head(popularidade_duracao)