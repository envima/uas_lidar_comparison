metrics = function(z){
  return(
    list(
      z_mean = mean(z),
      z_max = max(z),
      z_min = min(z),
      z_sd = sd(z),
      z_range = max(z) - min(z),
      z_shannon = vegan::diversity(z, index = "shannon"),
      n_points = length(z)
    )
  )
}

