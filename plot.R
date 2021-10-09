#plotagens

#plots para evadidos
ggplot(plot_evadidos, aes(y = qtd, x = forma_evasao, fill = forma_evasao)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Evasao") + 
  ylab("quantidade evadidos")+
  theme_light()

ggplot(plot_evadidos_2, aes(y = qtd, x = forma_saida, fill = forma_saida)) +
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
