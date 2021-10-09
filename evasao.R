#construcao tabelas para plots de evadidos LOAC
plot_evadidos <- data_evadido %>%
  group_by(forma_evasao)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

plot_evadidos_reingresso <- data_evadido %>%
  group_by(forma_saida)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

aprovados <- data.frame(forma_saida="Aprovado", qtd=aprovacoes$aprovacoes)

plot_saidas <- rbind(plot_evadidos_reingresso, aprovados)
