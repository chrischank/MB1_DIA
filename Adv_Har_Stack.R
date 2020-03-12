#Stacking Entropy, Variance, and Dissimilarity
#MB2_DIA

setwd("D:/MB1_DIA")

#Library----
library(tidyverse)
library(raster)
library(RStoolbox)
library(sp)
library(rasterVis)
library(rgdal)
library(viridis)
library(grDevices)

list.files()

b7_DEntropy <- raster("Adv_Har_Manila.tif", band=7)
b2_Variance <- raster("Adv_Har_Manila.tif", band=2)
b3_Dissimilarity <- raster("Adv_Har_Manila.tif", band=3)

stack_b723 <- stack(b7_DEntropy, b2_Variance, b3_Dissimilarity)

gplot(stack_b723)+
  geom_raster(aes(x=x, y=y, fill=value))+
  scale_fill_viridis_c()+
  facet_wrap(~variable)+
  coord_quickmap()+
  ggtitle("DEntropy(b7), Variance(b2), Dissimilarity(b3)")+
  xlab("Longitude")+
  ylab("Latitude")+
  theme_classic()+
  theme(text = element_text(size = 20),
axis.text.x = element_text(angle=90, hjust=1))+
  theme(plot.title = element_text(hjust=0.5))

ggsave("b7b2b3_Manila.png", scale=1.5, dpi=300)

image(stack_b723, col=viridis_pal(option="D") (10), main="Multivariate textural index (Adv_Har)")

png("MVTI(Adv_Har).png", width=4, height=4, units="in", res=300)
image(stack_b723, col=viridis_pal(option="D") (10), main="Multivariate textural index (Adv_Har)")
dev.off()

writeRaster(stack_b723, filename = "AdvHar_b723.tif", format = "GTiff", datatype="INT2S", overwrite=TRUE)

Build_tex <- getValues(stack_b723)
Kmeans_b723<- kmeans(na.omit(Build_tex), centers=10, iter.max=500, nstart=5, algorithm="Lloyd")

Build_tex_ras <- stack_b723
Build_tex_ras[] <- Kmeans_b723$cluster

par(mfrow = c(1, 2))
plot(stack_b723, col = rev(terrain.colors(10)), main = "Building texture (Adv Har)")
plot(Build_tex_ras, main = "Kmeans", col = viridis_pal(option = "D")(10))
