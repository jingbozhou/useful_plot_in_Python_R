# install.packages("ggplot2")
#options(scipen=999)  
# turn-off scientific notation like 1e+48
# load package and data
library(ggplot2)
# pre-set the bw theme.
# https://ggplot2.tidyverse.org/reference/ggtheme.html
theme_set(theme_bw())  
# data("midwest", package = "ggplot2")
midwest <- read.csv("../../data/midwest_filter.csv") 

# Scatterplot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=category), size=2) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 90000)) + 
  labs(title="Scatterplot of Midwest Area vs Population", 
       x="Area", 
       y="Population")

# Modify theme components
gg_final <- gg + theme(plot.title=element_text(size=14, 
                                   face="bold", 
                                   family="American Typewriter",
                                   color="black",
                                   hjust=0.5,
                                   lineheight=1.2),  # title
           
           axis.title.x=element_text(size=12),  # X axis title
           axis.text.x=element_text(size=12),
           axis.title.y=element_text(size=12),  # Y axis title
           ) + guides(color=guide_legend("")) # Change the Legend Title

plot(gg_final)

