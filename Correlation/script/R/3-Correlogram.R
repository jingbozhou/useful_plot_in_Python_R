# install.packages("ggplot2")
# install.packages("ggcorrplot")
#options(scipen=999)  
# turn-off scientific notation like 1e+48
# load package and data
library(ggplot2)
library(ggcorrplot)

# data(mtcars)
mtcars <- read.csv("../../data/mtcars.csv") 
# Correlation matrix
corr <- round(cor(mtcars[, 1:12]), 2)

# Plot
gg <- ggcorrplot(corr, hc.order = TRUE, 
                 type = "lower", 
                 lab = TRUE, 
                 lab_size = 3, 
                 method="circle", 
                 colors = c("tomato2", "white", "springgreen3"), 
                 ggtheme=theme_bw)

plot(gg)

