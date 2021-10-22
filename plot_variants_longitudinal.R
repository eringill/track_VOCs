library(ggplot2)
library(ggridges)
library(reshape)
library(dplyr)
library(viridis)
library(ggsci)
library(paletteer)

setwd('~/Projects/track_VOCs')

df <- read.csv('VOC_proportions.csv', header = TRUE)

df$week <- as.Date(df$week)

ggplot(df, aes(fill = identifier, x = week, y = percentage)) +
  geom_bar(position = 'fill', stat = 'identity') +
  scale_color_paletteer_d(ggsci, category20c_d3)

ggplot(df, aes(x = week, y = identifier))

head(diamonds)