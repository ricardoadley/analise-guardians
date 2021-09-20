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

#construcao do data frame para aprovacoes e reprovacoes na disciplina
rep_apv <- data.frame (
  aprovacoes,
  reprovacoes
)
#rep_apv$rep_sem_gradu <- rep_e_nao_graduou$reprovados
#rep_apv$total <- c(rep_apv$aprovacoes + rep_e_nao_graduou$reprovados)
rep_apv$pct_reprovacoes <- c(((100*rep_apv$reprovacoes)/(rep_apv$aprovacoes+rep_apv$reprovacoes)))
rep_apv$pct_aprovacoes <- c(((100*rep_apv$aprovacoes)/(rep_apv$aprovacoes+rep_apv$reprovacoes)))
#View(rep_apv)

#rep_apv$pct_reprovacao <- c(((100*rep_apv$reprovacoes)/rep_apv$total))

