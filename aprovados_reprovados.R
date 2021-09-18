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

