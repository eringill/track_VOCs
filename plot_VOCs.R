library(ggplot2)
library(ggridges)
library(reshape)
library(dplyr)
library(viridis)

setwd("~/Projects/track_VOCs/data")
seqs <- read.csv('canadaplot.csv', header = TRUE)

seqs$region <- factor(seqs$region)
seqs$type <- relevel(seqs$region, "alpha")

ggplot(seqs, aes(fill = type, y = cases, x = date)) +
  geom_bar(position = "fill", stat = "identity") +
  guides(x = guide_axis(angle = 90)) +
  ylab("proportion of cases") +
  scale_color_viridis(discrete = TRUE, option = "D")+
  scale_fill_viridis(discrete = TRUE) +
  ggtitle("Proportion of Canadian COVID-19 cases caused by VOCs alpha and gamma") +
  labs(fill='') 

ggsave("voc_proportions.png", width = 25, height = 25, units = 'cm')

ag_plot <- read.csv("ag_plot.csv", header = TRUE)

ag_plot$region <- factor(ag_plot$region)
ag_plot$region <- relevel(ag_plot$region, "Canada")

ggplot(ag_plot, aes(x = date, y = cases, fill = type)) +
  geom_bar(show.legend = TRUE, position = 'fill', stat = 'identity') +
  facet_wrap(~region, ncol = 1) +
  guides(x = guide_axis(angle = 90)) +
  ggtitle("Proportion of Canadian COVID-19 cases caused by VOCs alpha and gamma") +
  ylab("proportion of cases") +
  scale_color_viridis(discrete = TRUE, option = "D")+
  scale_fill_viridis(discrete = TRUE)

ggsave("voc_proportions_provs.png", width = 25, height = 25, units = 'cm')

can <- read.csv("canada_alpha.csv", header=TRUE)

ggplot(canada_alpha, aes(y = cases, x = date, color = type, group = type)) +
  geom_line() +
  guides(x = guide_axis(angle = 90)) +
  ylab("number of cases") +
  ggtitle("Total number of Canadian COVID-19 cases and cases caused by VOC alpha")

ggsave("canada_total_alpha_line_graph.png", width = 25, height = 25, units = 'cm')
