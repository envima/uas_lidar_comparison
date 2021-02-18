# import pointcloud indices

file.copy("~/casestudies/forest_pointcloud_indices/data/results/", to = "data/level0/",
          recursive = TRUE, overwrite = TRUE)
file.rename("data/level0/results/", "data/level0/pointcloud_indices")
