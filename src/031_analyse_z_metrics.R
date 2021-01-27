# analyze z metrics

# comparsion of late fall flight to early fall flight











fls = list.files("data/z_metrics_tables_10m/", pattern = ".RDS$", full.names = TRUE)

zm = lapply(fls, readRDS)
zm = do.call(rbind, zm)


ggplot(zm, aes(x = lidarfirst_2018_01_01, y = densecloud_2020_09_15))+
  geom_hex()+
  scale_fill_gradientn(name = "Count",colors = viridis(25), trans = "log")+
  geom_abline(slope = 1, intercept = 0, color = "red", lwd = 1)+
  facet_wrap(. ~ metric, scales = "free")+
  theme_bw()
  

