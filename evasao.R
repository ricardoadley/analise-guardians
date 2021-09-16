#separacao evadidos sem graduar
data_evadido <- loac %>%
  filter((stringr::str_detect(forma_evasao,"CANCE") | stringr::str_detect(forma_evasao,"TRANSFERIDO PARA OUTRA IES")) & situacao != "Aprovado")

#who <- historico %>%
 #filter(id == "W364306")

#somente_um_evadido <- data_evadido[!duplicated(data_evadido$id),]