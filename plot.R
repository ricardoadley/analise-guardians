

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



ggplot(plot_evadidos, aes(y = qtd, x = forma_evasao,fill = forma_evasao)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Evas?o") + 
  ylab("quantidade evadidos")+
  theme_light()

ggplot(plot_evadidos_2, aes(y = qtd, x = forma_saida,fill = forma_saida)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Saida") + 
  ylab("quantidade")+
  theme_light()

#histograma media aprovados
ggplot(data = data_apr, aes(x = media_final)) +
  geom_histogram(fill= 'blue')

#histograma media reprovados
ggplot(data = data_rep_unique, aes(x = media_final)) +
  geom_histogram(fill= 'blue')
