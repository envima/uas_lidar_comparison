#' PCI plot for one date with multiple resolutions
#' @description Creates lidar vs. densecloud plot matrix for comparing different raster resolutions
#' 
#' @param datasets_meta, the result of 002_create_level0_metadata.R
#' 
#'
#' @return list of ggplots
#'
#' @author Marvin Ludwig
#'
#' @export

#




pci_plot_resolution = function(datasets_meta){
  
  plots = datasets_meta %>% filter(datasource == "densecloud") %>% pull(date) %>% unique() %>% 
    map(function(d){
      
      datasets = datasets_meta %>% filter(date %in% c("2018_04_06", d))
      datasets = datasets %>% mutate(data = map(filepath, function(f){
        pci_df(stack(f))
      }))
      
      datasets = datasets %>% unnest(data) %>% na.omit()
      
      # normalize metric values between 0 and 1
      
      datasets = datasets %>% group_by(metric) %>%
        mutate(metric_value = (metric_value - min(metric_value, na.rm = TRUE))/(max(metric_value)-min(metric_value)))
      
      
      datasets_lidar = datasets %>% filter(datasource == "lidar")
      datasets = datasets %>% filter(datasource != "lidar")
      
      df = left_join(datasets, datasets_lidar, by = c("x", "y", "metric", "resolution"), suffix = c("_densecloud", "_lidar")) %>% na.omit()
      
      return(
        
        df %>% 
          ggplot(aes(x = metric_value_lidar, y = metric_value_densecloud))+
          geom_hex()+
          scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log10")+
          geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
          facet_grid(metric ~ resolution)+
          ggtitle(paste0("UAS date: ", d))+
          theme_bw()
        
      )
    })
  return(plots)
  
}





