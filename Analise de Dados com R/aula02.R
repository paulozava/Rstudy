install.packages("readr")
library(readr)

duracao <- read_csv('/home/laumzav/PycharmProjects/Rstudy/Analise de Dados com R/duracao.csv')
View(duracao)

install.packages("plyr")
library(plyr)
duracao <- rename(duracao, replace=c('user_id'='aluno', 'course_id'='curso', 'timeToFinish' = 'dias'))
View(duracao)

