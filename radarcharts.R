library(tidyverse)
library(shapefiles)
library(radarchart)

setwd("D:/MB1_DIA")
list.files()

#DN 0, 1, 4
Not_Slum <- read.shapefile("Not Slum")
"Low_Confidence|Suburb" <- read.shapefile("Low Confidence_Suburb")
High_Confident_Slum <- read.shapefile("Highly Confident Slum")
#sum, mean, st.dev, min, max, range

labs <- c("mean", "median", "st.dev", "min", "max", "range")

head(Not_Slum$dbf)
"Not Slum" <- data.frame("Labels"=labs,
  "b7 DEntropy"=c(0.906774, 1, 0.2909056, 0, 2, 2),
  "b2 Variance"=c(2.545697, 3, 0.5383756, 2, 4, 2),
  "b3 Dissimilarity"=c(0, 0, 0, 0, 0, 0))

Not_Slum_Star <- chartJSRadar(`Not Slum`, maxScale = 4, showToolTipLabel = TRUE, main="No Slum")

head(`Low_Confidence|Suburb`$dbf)
"Low Confidence Slum" <- data.frame("Labels"=labs,
  "b7 DEntropy"=c(0.9848802, 1, 0.139557, 0, 2, 2),
  "b2 Variance"=c(5.172819, 5, 1.162697, 4, 12, 8),
  "b3 Dissimilarity"=c(0, 0, 0, 0, 0, 0))

Low_Slum_Star <- chartJSRadar(`Low Confidence Slum`, maxScale = 12, showToolTipLabel = TRUE, main="Low Confidence")

head(High_Confident_Slum$dbf)
"Highly Confident Slum" <- data.frame("Labels"=labs,
  "b7 DEntropy"=c(0.8843341, 1, 0.3198238, 0, 1, 1),
  "b2 Variance"=c(0.5379927, 1, 0.4985545, 0, 1, 1),
  "b3 Dissimilarity"=c(0, 0, 0, 0, 0, 0))

High_Slum_Star <- chartJSRadar(`Highly Confident Slum`, maxScale = 1, showToolTipLabel = TRUE, main="High Confidence")

Not_Slum_Star
Low_Slum_Star
High_Slum_Star
