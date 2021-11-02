#plotagens

#plots para evadidos loac
ggplot(plot_evadidos_loac, aes(y = qtd, x = forma_evasao, fill = forma_evasao)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Evasao") + 
  ylab("quantidade evadidos")+
  theme_light()

ggplot(plot_evadidos_reingresso_loac, aes(y = qtd, x = forma_saida, fill = forma_saida)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Saida") + 
  ylab("quantidade")+
  theme_light()

#plots para evadidos oac
ggplot(plot_evadidos_oac, aes(y = qtd, x = forma_evasao, fill = forma_evasao)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Evasao") + 
  ylab("quantidade evadidos")+
  theme_light()

ggplot(plot_evadidos_reingresso_oac, aes(y = qtd, x = forma_saida, fill = forma_saida)) +
  geom_bar(stat = "identity")+
  xlab("Forma de Saida") + 
  ylab("quantidade")+
  theme_light()

#histograma media aprovados LOAC
ggplot(data = data_apr, aes(x = media_final)) +
  geom_histogram(fill='blue')

#histograma media reprovados LOAC
ggplot(data = data_rep_unique, aes(x = media_final)) +
  geom_histogram(fill='blue')


#histograma media aprovados OAC
ggplot(data = data_apr_OAC, aes(x = media_final)) +
  geom_histogram(fill='blue')

#histograma media reprovados OAC
ggplot(data = data_rep_OAC_unique, aes(x = media_final)) +
  geom_histogram(fill='blue')

#boxplot das notas de OAC e LOAC
notas <- list(oac_loac_unique$media_final.x, oac_loac_unique$media_final.y)
names(notas) <- list("OAC", "LOAC")
boxplot(notas, col="#69b3a2", ylab="notas")
