library(googlesheets4)
library(lubridate)
library(dotenv)

load_dot_env(file='./acnh.env')
sheet_url <- Sys.getenv("sheets_url")

# read in directly from Google Sheets
df <- read_sheet(sheet_url)

# convert to a POSIX date
df$Date <- ymd(df$Date)

# label day of week, week of year, and year
df$day_of_week <- wday(df$Date, label = TRUE, abbr = TRUE)
df$week <- epiweek(df$Date) # starts on Sunday
df$year <- year(df$Date)

write.csv(df, 'data/parsed.csv', row.names=FALSE, quote=FALSE)

