#importacao e construcao das tabelas

#Bibliotecas que vamos usar: 
# install.packages("tidyverse")
# install.packages("formattable")
library(tidyverse)
library(dplyr)
library(formattable)

#Importando histórico
historico <- read_csv("https://github.com/elasComputacao/raio-x-dados/blob/main/data/dados-brutos/historico_alunos_raiox.csv?raw=true")

#Intervalo que vamos utilizar: 2003 - 2020
historico <- historico %>% filter(periodo_ingresso > 2003)

#Captura os históricos apenas para LOAC
loac <- historico %>%
  filter(stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES"))

#Captura os históricos de alunos de LOAC por situação
data_rep <- loac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado")

data_apr <- loac %>%
  filter(situacao == "Aprovado")

data_evadido <- loac %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")

#Captura os históricos de alunos que reprovaram e evadiram sem ser aprovado em LOAC
data_rep_e_nao_graduou <- loac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado") & forma_evasao != "GRADUADO")


#Captura os históricos apenas para OAC
oac <- historico %>%
  filter(stringr::str_detect(nome_disciplina,"ORGANIZACAO DE COMPUTADORES") | stringr::str_detect(nome_disciplina,"ORG.E ARQUITETURA DE COMPUTADORES I"))

#Captura os históricos para OAC e LOAC
oac_loac <- historico %>%  filter (
  stringr::str_detect(nome_disciplina,"ORGANIZACAO DE COMPUTADORES") | 
  stringr::str_detect(nome_disciplina,"ORG.E ARQUITETURA DE COMPUTADORES I") |
  stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES")
)

evadidos_oac_loac <- left_join(oac_loac, data_evadido) %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")

# tabela usada para construcao do histograma e/ou outros plots para reprovados

#remove repeticoes da reprovacao para no histograma contar apenas uma pessoa
data_rep_unique <- data_rep[!duplicated(data_rep$id), ]

#remove valores nan da media final dos reprovados
data_rep_unique <- data_rep_unique %>%
  mutate( media_final = tidyr::replace_na(media_final, 0) )
