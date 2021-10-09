# Contagem aprovados e reprovados em LOAC
aprovacoes <- loac %>%
  filter(stringr::str_detect(situacao,"Apr"))%>%
  summarize(aprovacoes = n_distinct(id))

### considera reprovacao mesmo que passe depois
reprovacoes <- loac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado")%>%
  summarize(reprovacoes = n_distinct(id))


### considera apenas quem reprovou e não graduou(não foi aprovado eventualmente)
rep_e_nao_graduou <- loac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado") & forma_evasao != "GRADUADO")%>%
  summarize(reprovados = n_distinct(id))

# Construção do data frame para aprovações e reprovações na disciplina
rep_apv_loac <- data.frame (
  aprovacoes,
  reprovacoes
)
rep_apv_loac$total <- c(rep_e_nao_graduou$reprovados + rep_apv$aprovacoes)
rep_apv_loac$pct_reprovacoes <- c(percent(((100*rep_apv$reprovacoes)/(rep_apv$aprovacoes+rep_apv$reprovacoes))/100))


# Contagem aprovados e reprovados em OAC
aprovacoesOAC<- oac %>%
  filter(stringr::str_detect(situacao,"Apr"))%>%
  summarize(aprovacoes = n_distinct(id))

### considera reprovacao mesmo que passe depois
reprovacoesOAC <- oac %>% 
  filter(situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado")%>%
  summarize(reprovacoes = n_distinct(id))


### considera apenas quem reprovou e nao graduou
rep_e_nao_graduou_OAC <- oac %>% 
  filter((situacao == "Reprovado por Falta" | situacao == "Trancado" | situacao == "Reprovado") & forma_evasao != "GRADUADO")%>%
  summarize(reprovados = n_distinct(id))

# Construção do data frame para aprovações e reprovações na disciplina
rep_apv_oac <- data.frame (
  aprovacoesOAC,
  reprovacoesOAC
)
rep_apv_oac$total <- c(rep_e_nao_graduou_OAC$reprovados + rep_apv_oac$aprovacoes)
rep_apv_oac$pct_reprovacoes <- c(percent(((100*rep_apv_oac$reprovacoes)/(rep_apv_oac$aprovacoes+rep_apv_oac$reprovacoes))/100))
