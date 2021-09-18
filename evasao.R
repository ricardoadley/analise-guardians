#construcao tabelas para plots de evadidos
plot_evadidos <- data_evadido %>%
  group_by(forma_evasao)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

plot_evadidos_2 <- data_evadido %>%
  group_by(forma_saida)%>%
  summarise(qtd = n_distinct(id))%>%
  arrange(desc(qtd))

linha <- data.frame(forma_saida="Aprovado", qtd=aprovacoes$aprovacoes)

plot_evadidos_2 <- rbind(plot_evadidos_2, linha)
