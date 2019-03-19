# load the ggplot2 package
extrafont::loadfonts(device="win")
extrafont::loadfonts(device="pdf")
extrafont::loadfonts(device="postscript")
hrbrthemes::import_roboto_condensed()
library(hrbrthemes)
library(ggplot2)
library(ggthemes)
library(tidyverse)
library(gridExtra)
library(scales)
library(doBy)
df <- read_csv("sample.csv")
df <- as.data.frame(df)
df<-na.omit(df)
df$var1<-as.numeric(as.character(df$var1))
df$var2<-as.numeric(as.character(df$'var2'))

fill = c("green1", "palegreen1", "orange3", "orangered3", "grey48")

p6 <- ggplot(df, aes(x = var1, y = var2, size = var3, fill = var4)) +
  geom_point(shape = 21) +
  ggtitle("title") +
  labs(x = "var1 title", y = "var2 title",
       size = "size var", fill = "fill var") +
  scale_y_continuous(name="var2 title", labels = dollar_format(prefix="$")) +
  scale_size(range = c(1, 10), labels = dollar_format(prefix="$")) +
  scale_fill_manual(values = fill) +
  theme(legend.position = "right", legend.direction = "vertical",
        legend.box = "vertical",
        legend.key.size = unit(1, "cm"),
        axis.line = element_line(size=1, colour = "black"),
        panel.grid.major = element_line(colour = "#d3d3d3"),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(), panel.background = element_blank(),
        plot.title = element_text(size = 14, family = "sans", face = "bold"),
        text=element_text(family="sans"),
        axis.text.x=element_text(colour="black", size = 9),
        axis.text.y=element_text(colour="black", size = 9))
p6
