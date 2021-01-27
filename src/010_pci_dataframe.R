

fls = list.files("data/imports/pointcloud_indices/", pattern = ".grd$", recursive = TRUE, full.names = TRUE)

pci_df = purrr::map_dfr(fls, function(f){
  pci = stack(f)
  pci = as.data.frame(pci, xy = TRUE)
  pci$dataset = stringr::word(basename(f), sep = "\\.", start = 1, end = 1)
  return(pci)
})

