metrics = function(z){
  return(
    list(
      z_mean = mean(z),
      z_max = max(z),
      z_min = min(z),
      z_sd = sd(z),
      z_range = max(z) - min(z),
      n_points = length(z)
    )
  )
}


p_rate = grid_metrics(pc$lidar2018, func = ~length(Z), 1, filter = ~Z<2)
plot(p_rate)


