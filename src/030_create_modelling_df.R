# modelling

fsi = stack("data/imports/structural_indices/fsi.grd")




fsi = as.data.frame(fsi, xy = TRUE)
fsi = na.omit(fsi)


fsi$pk = paste0(fsi$x, fsi$y)
pci_df$pk = paste0(pci_df$x, fsi$y)


fsi = fsi %>% mutate(pk = paste0(x,y)) %>% select(-c("x", "y"))

pci_df = pci_df %>% mutate(pk = paste0(x,y)) %>% select(-c("x", "y"))

df = left_join(pci_df, fsi, by = "pk")
