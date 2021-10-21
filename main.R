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
historico <- historico %>% filter(periodo_matricula > 2003)

#Captura os históricos apenas para LOAC
loac <- historico %>%
  filter(stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES"))

#Captura os históricos de alunos de LOAC por situação
data_rep <- loac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Reprovado")

data_apr <- loac %>%
  filter(situacao == "Aprovado")

data_evadido <- loac %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | 
          stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) 
          & situacao != "Aprovado")

#Captura os históricos de alunos que reprovaram e evadiram sem ser aprovado em LOAC
data_rep_e_nao_graduou <- loac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Reprovado") & forma_evasao != "GRADUADO")

### Remove repeticoes da reprovacao para no histograma contar apenas uma pessoa
data_rep_unique <- data_rep[!duplicated(data_rep$id), ]

#Captura os históricos apenas para OAC
oac <- historico %>%
  filter(stringr::str_detect(nome_disciplina,"ORGANIZACAO E ARQUIT. DE COMPUTADORES") | stringr::str_detect(nome_disciplina,"ORGANIZACAO DE COMPUTADORES") | stringr::str_detect(nome_disciplina,"ORG.E ARQUITETURA DE COMPUTADORES I"))


#Captura os históricos de alunos de LOAC por situação
data_rep_OAC <- oac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Reprovado")

data_rep_OAC_unique <- data_rep_OAC[!duplicated(data_rep_OAC$id), ]

data_apr_OAC <- oac %>%
  filter(situacao == "Aprovado")

data_evadido_OAC <- oac %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | 
          stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) 
          & situacao != "Aprovado")

#Captura os históricos para OAC e LOAC
oac_loac <- oac %>% inner_join(loac, by=c("id")) %>% 
  select("id", "forma_evasao.x", "periodo_evasao.x", 
         "nome_disciplina.x", "situacao.x", "media_final.x",
         "nome_disciplina.y", "situacao.y", "media_final.y")

evadidos_oac_loac <- left_join(oac_loac_unique, data_evadido) %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")
