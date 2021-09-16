#libraries
library(tidyverse)
library(dplyr)
#data import
historico <- read_csv("https://github.com/elasComputacao/raio-x-dados/blob/main/data/dados-brutos/historico_alunos_raiox.csv?raw=true")

#separacao para loac
loac <- historico %>%
  filter(stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES")
         & periodo_ingresso >= 2014.1)
#pegar apartir de 1999 (?) 

#contagem aprovados e reprovados
aprovacoes<- loac %>%
  filter(stringr::str_detect(situacao,"Apr"))%>%
  summarize(aprovacoes = n_distinct(id))

#considera reprovacao mesmo que passe depois
reprovacoes <- loac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado")%>%
  summarize(reprovacoes = n_distinct(id))


#considera apenas quem reprovou e nao graduou
rep_e_nao_graduou <- loac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado") & forma_evasao != "GRADUADO")%>%
  summarize(reprovados = n_distinct(id))

#construcao do data frame
rep_apv <- data.frame (
  aprovacoes,
  reprovacoes
)
rep_apv$rep_sem_gradu <- rep_e_nao_graduou$reprovados
rep_apv$total <- c(rep_apv$aprovacoes + rep_apv$rep_sem_gradu)
rep_apv$pct_reprovados <- c(((100*rep_apv$rep_sem_gradu)/rep_apv$total))
rep_apv$pct_aprovados <- c(((100*rep_apv$aprovacoes)/rep_apv$total))
rep_apv$pct_reprovacao <- c(((100*rep_apv$reprovacoes)/rep_apv$total))

#separacao reprovados 
data_rep <- loac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado")

data_apr <- loac %>%
  filter(situacao == "Aprovado")

data_rep_e_nao_graduou <- loac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado") & forma_evasao != "GRADUADO")

grupo_azul <- historico %>%
  filter((stringr::str_detect(nome_disciplina,"LAB.DE ORG.E ARQUITETURA DE COMPUTADORES") |
           stringr::str_detect(nome_disciplina,"ORGANIZACAO DE COMPUTADORES") | stringr::str_detect(nome_disciplina,"ORG.E ARQUITETURA DE COMPUTADORES I")) & periodo_ingresso >= 2014.1
           )

huum <- left_join(grupo_azul,data_evadido)

huum <- huum %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")

#juntar com ic tbm

#separar melhor os scrip e fazer novo pdf

# histograma de aprovados e um de reprovados (pelas notas)

