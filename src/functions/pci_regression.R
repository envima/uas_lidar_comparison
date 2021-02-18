#' Compare pointcloud indices
#' @description Compare two stacks of pointcloud indices
#' 
#' @param pcix rasterStack - the predictor set
#' @param pciy rasterStack - the response set
#' 
#' @details pcix and pciy are interchangeable and refere to x and y axis in a scatterplot 
#'
#' @return
#'
#' @author Marvin Ludwig
#'
#' @export

#



pci_compare = function(pcix, pciy){
  
  pcix = pci_df(pcix) %>% rename(predictor = metric_value)
  pciy = pci_df(pciy) %>% rename(response = metric_value)
  pci = left_join(pcix, pciy) %>% na.omit()
  
  pci = pci %>% group_by(metric) %>% nest()
  
  mod_fun = function(df){
    regression = as.formula("response ~ predictor")
    lm(regression, data = df)
  }
  
  stat_fun = function(lmod){
    data.frame(Rsq = round(summary(lmod)$r.squared, 3),
               p = round(summary(lmod)$coefficients[2,4], 6),
               intercept = summary(lmod)$coefficients[1,1],
               slope = summary(lmod)$coefficients[2,1])
  }
  
  
  pci = pci %>% mutate(model = map(data, mod_fun))
  pci = pci %>% mutate(results = map(model, stat_fun))
  
  return(pci)
  
  
}




pci_df = function(f){
  pci = as.data.frame(f, xy = TRUE)
  pci = melt(pci, id.vars = c("x", "y"), variable.name = "metric", value.name = "metric_value")
  return(pci)
}



pci_plot = function(pcix, pciy){
  pcix = pci_df(pcix) %>% rename(predictor = metric_value)
  pciy = pci_df(pciy) %>% rename(response = metric_value)
  pci = left_join(pcix, pciy) %>% na.omit()
  
  
  ggplot(pci, aes(x = predictor, y = response))+
    geom_hex()+
    scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
    geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
    facet_wrap(.~metric, scales = "free")+
    theme_bw()
}



