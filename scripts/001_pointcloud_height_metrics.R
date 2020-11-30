metrics = function(z){
  return(
    list(
      z_mean = mean(z),
      z_max = max(z),
      z_min = min(z),
      z_sd = sd(z),
      z_mad = mad(z)
    )
  )
}
