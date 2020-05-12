# Correlation

相关图用于可视化两个或多个变量之间的关系或相关程度。

## Scatteplot

散点图(Scatteplot)是研究两个变量之间关系的比较经典的图。当想了解两个变量之间的关系时，首选散点图。

1. R: It can be drawn using `geom_point()`.

```R
# install.packages("ggplot2")
#options(scipen=999)  
# turn-off scientific notation like 1e+48
# load package and data
library(ggplot2)
# pre-set the bw theme.
# https://ggplot2.tidyverse.org/reference/ggtheme.html
theme_set(theme_bw())  
# data("midwest", package = "ggplot2")
midwest <- read.csv("./data/midwest_filter.csv") 

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
```


2. Python: In `matplotlib`, you can using `plt.scatterplot()`.


```Python
# Import module
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline

# Import dataset
data_path = "./data/midwest_filter.csv"
midwest = pd.read_csv(data_path)

# Prepare Data 
# Create as many colors as there are unique midwest['category']
categories = np.unique(midwest['category'])
# plt.cm.tab20
# https://www.osgeo.cn/matplotlib/tutorials/colors/colormaps.html
# https://matplotlib.org/3.1.1/tutorials/colors/colormaps.html
colors = [np.array(plt.cm.tab20(i)).reshape(1, -1) 
          for i in range(len(categories))]

# Draw Plot for Each Category
# figsize - tuple of integers , 指定figure的宽和高，单位为英寸 ，
# 若无提供，defaults to rc figure.figsize.
# dpi - 图形的分辨率
# faceclor - 背景色，若缺省，则 defaults to rc figure.facecolor.
# edgecolor - 边框颜色，若缺省，则 defaults to rc figure.edgecolor.
plt.figure(figsize=(16, 10), dpi= 80, 
           facecolor='w', edgecolor='k')

# https://matplotlib.org/3.2.1/api/_as_gen/matplotlib.pyplot.scatter.html
for i, category in enumerate(categories):
    plt.scatter('area', 'poptotal', 
                data=midwest.loc[midwest.category==category, :], 
                s=40, c=colors[i], label=str(category))

# Decorations
# 横纵坐标的刻度及标签大小
params = {
    'xtick.labelsize': 18,
    'ytick.labelsize': 18,
    'axes.titlesize': 24
}
plt.rcParams.update(params)

# plt.gca(): 返回当前axes(matplotlib.axes.Axes)
# 横纵坐标的刻度及标签
plt.gca().set(xlim=(0.0, 0.1), ylim=(0, 90000),
              xlabel='Area', ylabel='Population')


plt.title("Scatterplot of Midwest Area vs Population", fontsize=24)
plt.legend(fontsize=18)    
#plt.savefig("./img/Python/1-scatteplot.png", bbox_inches="tight")
plt.show()
```
