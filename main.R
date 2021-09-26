#importacao e construcao das tabelas

#libraries
#install.packages("tidyverse")
#install.packages("formattable")
library(tidyverse)
library(dplyr)
library(formattable)
#data import
historico <- read_csv("https://github.com/elasComputacao/raio-x-dados/blob/main/data/dados-brutos/historico_alunos_raiox.csv?raw=true")

#separacao para loac
loac <- historico %>%
  filter(stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES"))
#pegar apartir de 1999 (?) 

#separacao reprovados 
data_rep <- loac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado")

data_apr <- loac %>%
  filter(situacao == "Aprovado")

data_rep_e_nao_graduou <- loac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado") & forma_evasao != "GRADUADO")
#separacao evadidos sem graduar
data_evadido <- loac %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")


#codigo ainda em teste, juncao com disciplica oac
grupo_azul <- historico %>%
  filter((stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES") |
           stringr::str_detect(nome_disciplina,"ORGANIZACAO DE COMPUTADORES") | stringr::str_detect(nome_disciplina,"ORG.E ARQUITETURA DE COMPUTADORES I"))
          )

huum <- left_join(grupo_azul,data_evadido)

huum <- huum %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")

#juntar com ic tbm

#separar melhor os scrip e fazer novo pdf

# tabela usada para construcao do histograma e/ou outros plots para reprovados

#remove repeticoes da reprovacao para no histograma contar apenas uma pessoa
data_rep_unique <- data_rep[!duplicated(data_rep$id), ]

#remove valores nan da media final dos reprovados
data_rep_unique <- data_rep_unique %>%
  mutate(media_final = tidyr::replace_na(media_final, 0))
