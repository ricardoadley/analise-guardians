# Construção tabelas para plots de evadidos LOAC
plot_evadidos_loac <- data_evadido %>%
  group_by(forma_evasao)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

plot_evadidos_reingresso_loac <- data_evadido %>%
  group_by(forma_saida)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

aprovados_loac <- data.frame(forma_saida="Aprovado", qtd=aprovacoes$aprovacoes)

plot_saidas_loac <- rbind(plot_evadidos_reingresso, aprovados)

#Construção tabelas para plots de evadidos OAC
plot_evadidos_oac <- data_evadido_OAC %>%
  group_by(forma_evasao)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

plot_evadidos_reingresso_oac <- data_evadido_OAC %>%
  group_by(forma_saida)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

aprovados_oac <- data.frame(forma_saida="Aprovado", qtd=aprovacoesOAC$aprovacoes)

plot_saidas_oac <- rbind(plot_evadidos_reingresso_oac, aprovados_oac)