#' PCI comparison dataframe
#' @description Creates lidar vs. densecloud dataframe
#' 
#' @param datasets_meta, the result of 002_create_level0_metadata.R
#' 
#'
#' @return dataframe
#'
#' @author Marvin Ludwig
#'
#' @export

#


load_data = function(datasets_meta){
  
  plots = datasets_meta %>% filter(datasource %in% c("densecloud", "multi")) %>% pull(date) %>% unique() %>% 
    map_dfr(function(d){
      
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
      
      
      # format facet label
      df$resolution = paste0(df$resolution, "m")
      df$resolution = as.factor(df$resolution) %>% fct_inorder()
      
      
      
      return(df)
    })
  return(plots)
  
}





