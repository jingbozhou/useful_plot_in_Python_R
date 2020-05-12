# useful_plot_in_Python_R
Most useful plot in data analysis and visualization by matplotlib and ggplot2

# Correlation

相关图用于可视化两个或多个变量之间的关系或相关程度。

## Scatteplot

散点图(Scatteplot)是研究两个变量之间关系的比较经典的图。当想了解两个变量之间的关系时，首选散点图。如果数据有多个组，则需要用不同颜色来区分不同组。

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
![](https://github.com/jingbozhou/useful_plot_in_Python_R/raw/master/Correlation/img/R/1-scatteplot.png)



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

![](https://github.com/jingbozhou/useful_plot_in_Python_R/raw/master/Correlation/img/Python/1-scatteplot.png)

## Bubble plot with Encircling

如果希望散点图中有一组数据可以显示点的大小，这样的的图称为气泡图，此外还希望可以用边界画出一些比较重要的值，就可以用此图。

1. R:

```R
# install.packages("ggplot2")
# install.packages("ggalt")
#options(scipen=999)  
# turn-off scientific notation like 1e+48
# load package and data
library(ggplot2)
library(ggalt)
# pre-set the bw theme.
# https://ggplot2.tidyverse.org/reference/ggtheme.html
theme_set(theme_bw())  
# data("midwest", package = "ggplot2")
midwest <- read.csv("../../data/midwest_filter.csv") 

# Select data to be encircled   选择要环绕的数据
midwest_encircle_data = midwest[midwest$state=='IN',]

# Scatterplot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=category), size=2) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 90000)) + 
  geom_encircle(aes(x=area, y=poptotal), 
                data=midwest_encircle_data, 
                color="red", 
                size=2, 
                expand=0) +
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
![](https://github.com/jingbozhou/useful_plot_in_Python_R/raw/master/Correlation/img/R/2-Encircling.png)


2. Python:

```Python
# Import module
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.spatial import ConvexHull
import seaborn as sns

%matplotlib inline

# Import dataset
data_path = "./data/midwest_filter.csv"
midwest = pd.read_csv(data_path)

# Step 1: Prepare Data 
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

# Step 2: Draw Scatterplot with unique color for each category
# https://matplotlib.org/3.2.1/api/_as_gen/matplotlib.pyplot.scatter.html
for i, category in enumerate(categories):
    plt.scatter('area', 'poptotal', 
                data=midwest.loc[midwest.category==category, :], 
                s='dot_size', c=colors[i], label=str(category), 
                edgecolors='black', linewidths=.5)

# Step 3: Encircling
# https://stackoverflow.com/questions/44575681/how-do-i-encircle-different-data-sets-in-scatter-plot
def encircle(x, y, ax=None, **kw):
    # # plt.gca(): 返回当前axes(matplotlib.axes.Axes)
    if not ax: ax=plt.gca()
    # 行连接两个矩阵，就是把两矩阵左右相加，要求行数相等
    p = np.c_[x, y]
    # https://docs.scipy.org/doc/scipy-0.19.1/reference/generated/scipy.spatial.ConvexHull.html
    hull = ConvexHull(p)
    # https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.patches.Polygon.html
    poly = plt.Polygon(p[hull.vertices,:], **kw)
    ax.add_patch(poly)

# Select data to be encircled   选择要环绕的数据    
midwest_encircle_data = midwest.loc[midwest.state=='IN', :]                         

# Draw polygon surrounding vertices   绘制围绕顶点的多边形
encircle(midwest_encircle_data.area, midwest_encircle_data.poptotal, 
         ec="k", fc="gold", alpha=0.1)
encircle(midwest_encircle_data.area, midwest_encircle_data.poptotal, 
         ec="firebrick", fc="none", linewidth=1.5)    


# Step 4: Decorations
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
#plt.savefig("./img/Python/2-Encircling.png", bbox_inches="tight")
plt.show()
```
![](https://github.com/jingbozhou/useful_plot_in_Python_R/raw/master/Correlation/img/Python/2-Encircling.png)


## Correllogram

关联图可以直观的观察多个连续变量的相关性。

1. R:

```R
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
```
![](https://github.com/jingbozhou/useful_plot_in_Python_R/raw/master/Correlation/img/R/3-Correlogram.png)

2. Python:

```Python
# Import module
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline

# Import Dataset
df = pd.read_csv("./data/mtcars.csv")

# Draw Plot for Each Category
# figsize - tuple of integers , 指定figure的宽和高，单位为英寸 ，
# 若无提供，defaults to rc figure.figsize.
# dpi - 图形的分辨率
plt.figure(figsize=(16, 10), dpi= 80)

# Plot
# https://seaborn.pydata.org/generated/seaborn.heatmap.html
sns.heatmap(df.corr(), 
            xticklabels=df.corr().columns, 
            yticklabels=df.corr().columns, 
            cmap='RdYlGn', 
            center=0, 
            annot=True)

# Decorations
# Step 4: Decorations
# 横纵坐标的刻度及标签大小
params = {
    'xtick.labelsize': 18,
    'ytick.labelsize': 18,
}
plt.rcParams.update(params)

plt.title('Correlogram of mtcars', fontsize=24)
#plt.savefig("./img/Python/3-Correllogram.png", bbox_inches="tight")
plt.show()
```
![](https://github.com/jingbozhou/useful_plot_in_Python_R/raw/master/Correlation/img/Python/3-Correllogram.png)
