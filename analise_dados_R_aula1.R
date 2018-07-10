library(readxl)
aulas <- read_excel("aulas.xlsx")
attach(aulas)
# View(aulas)
# legendas do arquivo
# user_id = usuário do curso
# course_id = curso realizado
# section_id = video específico do curso

sort(section_id)
head(section_id)

#corrigindo umo outlier
aulas[33137, 3] <- 3255
attach(aulas)
tail(section_id)

View(unique(sort(section_id)))
length(unique(sort(section_id)))