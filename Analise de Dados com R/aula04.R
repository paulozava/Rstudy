setwd('/home/laumzav/PycharmProjects/Rstudy/Analise de Dados com R/')

library(readr)
populariade <- read_csv('popularidade.csv')
duracao <- read_csv('duracao.csv')

library(plyr)
duracao <- rename(duracao, replace=c('user_id'='aluno', 'course_id'='curso', 'timeToFinish' = 'dias'))
populariade <- rename(populariade, replace=c('course_id'='curso', 'freq'='frequencia'))
head(populariade)

sumario_media <- aggregate(duracao$dias, list(duracao$curso), mean, na.rm=TRUE)
sumario_mediana <- aggregate(duracao$dias, list(duracao$curso), median, na.rm=TRUE)
head(sumario_media)

sumario <- merge(sumario_media, sumario_mediana, by = 'Group.1')
head(sumario)
sumario <- rename(sumario, replace=c('Group.1'='curso', 'x.x'='media', 'x.y'='mediana'))
head(sumario)

popularidade_duracao <- merge(sumario, populariade, by = 'curso')
head(popularidade_duracao)

popularidade_duracao$X1 <- NULL