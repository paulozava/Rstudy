# Assumimos a disponibilidade do MongoDB

library (mongolite)
m <- mongo("clima_consolidado", url = "mongodb://localhost:27017/dbclima")
df_clima_consolidado <- m$find ('{}')

library(jsonlite)
df_clima_consolidado = flatten(df_clima_consolidado)

###
# Eliminando 11 variáveis não úteis
df_clima_consolidado$history.observations.pressurei <- NULL
df_clima_consolidado$history.observations.tempi <- NULL
df_clima_consolidado$history.observations.dewpti <- NULL
df_clima_consolidado$history.observations.heatindexi <- NULL
df_clima_consolidado$history.observations.windchilli <- NULL
df_clima_consolidado$history.observations.visi <- NULL
df_clima_consolidado$history.observations.wspdi <- NULL
df_clima_consolidado$history.observations.wdird <- NULL
df_clima_consolidado$history.observations.icon <- NULL
df_clima_consolidado$history.observations.wgusti <- NULL
df_clima_consolidado$history.observations.precipi <- NULL

# Padronizando nomes (denominações em inglês)
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'posicao'] <- 'id'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'estado'] <- 'state'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'cidade'] <- 'city'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'formato'] <- 'shape'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'dia'] <- 'mday'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'mes'] <- 'month'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'ano'] <- 'year'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'hora'] <- 'hour'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'cor'] <- 'colour'

# Simplificando denominações
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.tempm'] <- 'temp'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.hail'] <- 'hail'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.heatindexm'] <- 'heatindex'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.windchillm'] <- 'windchill'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.rain'] <- 'rain'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.vism'] <- 'vis'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.wdire'] <- 'wdire'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.dewptm'] <- 'dewpt'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.thunder'] <- 'thunder'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.fog'] <- 'fog'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.precipm'] <- 'precip'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.wspdm'] <- 'wspd'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.tornado'] <- 'tornado'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.hum'] <- 'hum'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.snow'] <- 'snow'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.wgustm'] <- 'wgust'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.conds'] <- 'conds'
colnames(df_clima_consolidado)[colnames(df_clima_consolidado)== 'history.observations.pressurem'] <- 'pressure'

###
# Ajuste de tipos em 10 variáveis numéricas. 
df_clima_consolidado$temp = as.numeric(df_clima_consolidado$temp)
df_clima_consolidado$heatindex = as.numeric(df_clima_consolidado$heatindex)
df_clima_consolidado$windchill = as.numeric(df_clima_consolidado$windchill)
df_clima_consolidado$vis = as.numeric(df_clima_consolidado$vis)
df_clima_consolidado$dewpt = as.numeric(df_clima_consolidado$dewpt)
df_clima_consolidado$precip = as.numeric(df_clima_consolidado$precip)
df_clima_consolidado$wspd = as.numeric(df_clima_consolidado$wspd)
df_clima_consolidado$wgust = as.numeric(df_clima_consolidado$wgust)
df_clima_consolidado$hum = as.numeric(df_clima_consolidado$hum)
df_clima_consolidado$pressure = as.numeric(df_clima_consolidado$pressure)

#Ajuste de "flags"
df_clima_consolidado$rain = as.integer(df_clima_consolidado$rain)
df_clima_consolidado$fog = as.integer(df_clima_consolidado$fog)
df_clima_consolidado$tornado = as.integer(df_clima_consolidado$tornado)
df_clima_consolidado$hail = as.integer(df_clima_consolidado$hail)
df_clima_consolidado$thunder = as.integer(df_clima_consolidado$thunder)
df_clima_consolidado$snow = as.integer(df_clima_consolidado$snow)

# Ajustando valores duplicados
df_clima_consolidado$shape[df_clima_consolidado$shape == 'CHEVRON'] <- 'Chevron'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'CIRCLE'] <- 'Circle'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'DIAMOND'] <- 'Diamond'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'DISK'] <- 'Disk'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'FIREBALL'] <- 'Fireball'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'FLASH'] <- 'Flash'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'FORMATION'] <- 'Formation'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'LIGHT'] <- 'Light'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'OTHER'] <- 'Other'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'OVAL'] <- 'Oval'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'SPHERE'] <- 'Sphere'
df_clima_consolidado$shape[df_clima_consolidado$shape == 'TRIANGLE'] <- 'Triangle'
df_clima_consolidado$shape[is.na(df_clima_consolidado$shape)] <- 'Other'
