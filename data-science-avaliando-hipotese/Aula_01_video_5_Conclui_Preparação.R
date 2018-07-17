# Procedimento para gerar um data frame com observações melhor distribuídas
geraCenario <- function(ent_volume, df_clima_consolidado)
{
  df_tipo_vs_visualiz <- df_clima_consolidado %>% 
    select (state:hour) %>%						
    filter(!shape %in% c("Other")) %>%
    group_by (shape) %>%
    summarise(quantas =  n()) %>%
    filter(quantas > ent_volume) %>%
    arrange (desc(quantas)) 
  
  df_OVNI <- df_clima_consolidado[(df_clima_consolidado$shape 
                                   %in% df_tipo_vs_visualiz$shape),] 
  
  tipos <- unique(df_tipo_vs_visualiz$shape) # tipos[1] é Light
  df_final <- data.frame()
  for (t in tipos){
    x <- df_OVNI[ sample( which( df_OVNI$shape == t ) , ent_volume ) , ]
    df_final <- rbind(df_final,x)
  }
  #rownames(df_final) <- c() # get rid of row names
  df_OVNI <- df_final
  return (rbind(df_OVNI)) 
}
# Fim rotina geraCenario

# Chamada
library(dplyr)
df_clima_consolidado_final <- geraCenario (4000, df_clima_consolidado) 

# Estrutura auxiliar para identificar os distintos tipos
tipos = df_clima_consolidado_final %>%  distinct (shape)
tipos$shapeNum = as.numeric(rownames(tipos))
colnames(tipos) <- c("shape", "shapeNum")
tipos <- as.data.frame(tipos)

# teste
#x <- tipos$shapeNum[tipos$shape == "Sphere"]

# Unindo duas estruturas. Na prática acrescentamos mais uma coluna
df_clima_consolidado_final <- df_clima_consolidado_final %>% 
  inner_join(tipos, by = "shape")  %>% 
  arrange(year, month, mday)

#Normalização
df_clima_consolidado_final$pressure = scale(df_clima_consolidado_final$pressure)
df_clima_consolidado_final$temp = scale(df_clima_consolidado_final$temp)
df_clima_consolidado_final$rain = scale(df_clima_consolidado_final$rain)
df_clima_consolidado_final$vis = scale(df_clima_consolidado_final$vis)
df_clima_consolidado_final$dewpt = scale(df_clima_consolidado_final$dewpt)
df_clima_consolidado_final$thunder = scale(df_clima_consolidado_final$thunder)
df_clima_consolidado_final$fog = scale(df_clima_consolidado_final$fog)
df_clima_consolidado_final$wspd = scale(df_clima_consolidado_final$wspd)
df_clima_consolidado_final$hum = scale(df_clima_consolidado_final$hum)
df_clima_consolidado_final$snow = scale(df_clima_consolidado_final$snow)



# Gravação versão definitiva
setwd("/home/laumzav/PycharmProjects/Rstudy/data-science-avaliando-hipotese/")
write.csv(df_clima_consolidado_final, file =  "clima_consolidado_final.csv",  row.names=FALSE, na = "")
