library(readr)
library(lubridate)
library(ggplot2)
library(stringr)

df <- read.csv('./data/parsed.csv', stringsAsFactors = FALSE, na = c("", "NA"))

level_order <- c("Sun", "Mon AM", "Mon PM", "Tue AM", "Tue PM", "Wed AM", 
                 "Wed PM", "Thu AM", "Thu PM", "Fri AM", "Fri PM", "Sat AM", "Sat PM")

# clean up data types
df$Date <- ymd(df$Date)

df$day_time <- str_c(df$day_of_week, str_replace_na(df$Time, replacement=""), sep=" ")
df$day_time <- trimws(df$day_time)
df$day_time <- factor(df$day_time, levels = level_order)

ggplot( df , aes(x=day_time, y=Price, color=week )) + 
  geom_point(size=3) +  
  facet_wrap(~Island) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, hjust = 1)) + 
  scale_x_discrete()
ggsave("./plots/per_island_prices.png")
