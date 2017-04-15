setwd("/Users/shotashimizu/git/Coursera-Data-Science/Exploratory_Data_Analysis/2nd/course_project_1/")
tmp <- read.table("../data/household_power_consumption.txt",
                  header = T,
                  sep = ";",
                  na.strings = "?",
                  colClasses = c(rep("character",2),rep("numeric",7)),
                  skip = as.integer(396 + 1440* (ymd("2007-2-1") - ymd("2006-12-16")-1)),
                  nrows = 1440*2)

names <- read.table("../data/household_power_consumption.txt",
                    sep = ";",
                    colClasses = c(rep("character",9)),
                    nrows = 1)

names(tmp) <- names

library(lubridate)
library(dplyr)

tmp2 <- tbl_df(tmp[complete.cases(tmp),])
df <- tmp2 %>%
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

rm(tmp)
rm(tmp2)

dev.new(width=480,height=480)
{
  hist(df$Global_active_power, 
       col = "red",
       xlim = range(c(0,6)),
       xlab = "Global Active Power(kilowatts)", 
       ylab = "Frequency", 
       main="Global Active Power")
}
dev.copy(png, "plot1.png", width=480, height=480, units = "px")
dev.off()

getwd()
setwd("/Users/shotashimizu/git/Coursera-Data-Science/Exploratory_Data_Analysis/2nd/course_project_1/")
png(file = "plot1.png", width=480, height=480, units = "px")
{
  with(df, hist(
    Global_active_power, 
    col = "red",
    xlim = range(c(0,6)),
    xlab = "Global Active Power(kilowatts)", 
    ylab = "Frequency", 
    main="Global Active Power",
    xaxt = "n",
    yaxt = "n")
  )
  axis(1, at = seq(0,6,by=2),las=2)
  axis(2, at = seq(0,1200,by=200), las = 2)
}
dev.off()