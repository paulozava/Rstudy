# Padronização de valores nulos
df_clima_consolidado[df_clima_consolidado=="-9999" | 
                       df_clima_consolidado=="-999" |
                       df_clima_consolidado=="-9999.0" |
                       df_clima_consolidado=="-9999.00" |
                       df_clima_consolidado=="" |
                       df_clima_consolidado=="NaN" 
                     ]<-NA



# Extrai campos numéricos
numericos <- unlist(sapply(df_clima_consolidado, function(x) is.numeric(x) || is.integer (x)))  
df_numericos <- df_clima_consolidado[, numericos]
  
  
#Investigando percentual de preenchimento
#sapply(df_numericos, function(x) 100-sum(is.na(x))/43543*100)

#Eliminando campos com preenchimento abaixo de 90%
df_clima_consolidado$heatindex <- NULL
df_clima_consolidado$windchill <- NULL
df_clima_consolidado$precip <- NULL
df_clima_consolidado$wgust <- NULL


#Investigando distribuição de valores (depois de atualizar df_numericos)
#sapply(df_numericos, function(x) summary(x))

#Eliminando variáveis preenchidas de forma desigual 
#ou desnecessárias para efeitos de classificação preditiva
# Comprove com: table(df_clima_consolidado$<<campo>>)
df_clima_consolidado$id <- NULL
df_clima_consolidado$hail <- NULL
df_clima_consolidado$tornado <- NULL


#Preencher valores faltando por interpolação (média)
df_clima_consolidado$pressure[is.na(df_clima_consolidado$pressure)] <- mean(df_clima_consolidado$pressure, na.rm = TRUE)
df_clima_consolidado$temp[is.na(df_clima_consolidado$temp)] <- mean(df_clima_consolidado$temp, na.rm = TRUE)
df_clima_consolidado$vis[is.na(df_clima_consolidado$vis)] <- mean(df_clima_consolidado$vis, na.rm = TRUE)
df_clima_consolidado$dewpt[is.na(df_clima_consolidado$dewpt)] <- mean(df_clima_consolidado$dewpt, na.rm = TRUE)
df_clima_consolidado$wspd[is.na(df_clima_consolidado$wspd)] <- mean(df_clima_consolidado$wspd, na.rm = TRUE)
df_clima_consolidado$hum[is.na(df_clima_consolidado$hum)] <- mean(df_clima_consolidado$hum, na.rm = TRUE)
colnames(df_numericos)
rm(df_numericos)

