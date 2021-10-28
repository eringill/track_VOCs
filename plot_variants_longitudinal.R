library(ggplot2)
library(ggridges)
library(reshape)
library(dplyr)
library(viridis)
library(ggsci)
library(paletteer)
library(ggpattern)

setwd('~/Projects/track_VOCs')

df <- read.csv('VOC_proportions.csv', header = TRUE)

df$week <- as.Date(df$week)

df <- df[!(df$week < "2020-04-01"),]

df$group_variant <- ifelse(df$grouping %in% c("VOI", "Other"), df$grouping, df$identifier)


ggplot(df, aes(fill = identifier, x = week, y = percentage, hue = identifier)) +
  geom_bar(position = 'fill', stat = 'identity') +
  guides(fill = guide_legend(title="Variant / Lineage")) +
  scale_fill_d3("category20") +
  guides(x = guide_axis(angle = 90)) +
  scale_x_date(date_breaks = "2 month", date_labels = "%m-%Y") +
  xlab("Week") +
  ylab("Proportion") +
  ggtitle("Proportion of SARS-CoV-2 samples collected and sequenced\nby variant / lineage and week in Canada")

ggsave("variants_lineages_by_week.png", width = 15, height = 15, units = 'cm')

ggplot(df, aes(fill = group_variant, x = week, y = percentage, hue = group_variant)) +
  geom_bar(position = 'fill', stat = 'identity') +
  guides(fill = guide_legend(title="Variant / Lineage")) +
  scale_fill_d3("category20") +
  guides(x = guide_axis(angle = 90)) +
  scale_x_date(date_breaks = "2 month", date_labels = "%m-%Y") +
  scale_y_continuous(labels = scales::percent) +
  xlab("Month") +
  ylab("Percent") +
  ggtitle("Proportion of SARS-CoV-2 samples collected and sequenced\nby variant / lineage and month in Canada")

ggsave("variants_lineages_by_week_simplified.png", width = 15, height = 15, units = 'cm')

# French version
df$group_variant <- factor(df$group_variant, levels=c('Alpha', 'Beta', 'Delta',
                                                      'Gamma', 'Other', 'VOI'),
                           labels=c('Alpha', 'Bêta', 'Delta', 'Gamma', 'Autre', 'Variant d\'intêret'))
ggplot(df, aes(fill = group_variant, x = week, y = percentage, hue = group_variant)) +
  geom_bar(position = 'fill', stat = 'identity') +
  guides(fill = guide_legend(title="Variant / souche")) +
  scale_fill_d3("category20") +
  guides(x = guide_axis(angle = 90)) +
  scale_x_date(date_breaks = "2 month", date_labels = "%m-%Y") +
  scale_y_continuous(labels = scales::percent) +
  xlab("Mois") +
  ylab("Pourcentage") +
  ggtitle("Proportion d'échantillions de SARS-CoV-2 recueillis et\nséquencés par variant / souche et mois au Canada")

ggsave("variants_lineages_by_week_simplified_fr.png", width = 15, height = 15, units = 'cm')
