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
  mutate(Date = dmy(Date)) %>%
  filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02")) %>%
  mutate(DateTime  = ymd_hms(paste(Date,Time)))


png(file = "plot4.png", width=480, height=480, units = "px")
{par(mfcol = c(2,2))
  # plot1
  #{
  with(df,plot(DateTime,Global_active_power,
               xlab = "",
               ylab = "Global Active Power(kilowatts)",
               #xaxt = "n",
               yaxt = "n",
               type = "l"
  ))
  axis(2, at = seq(0,6,by=2),las=2)
  #axis(1, at = seq(0,1200,by=200), las = 2)
  #}
  
  
  # plot2
  #{
  with(df,{
    plot(DateTime,Sub_metering_1,
         xlab = "",
         ylab = "Energy Sub Metering",
         #xaxt = "n",
         yaxt = "n",
         type = "l"
    )
    lines(DateTime, Sub_metering_2,
          col = "red")
    lines(DateTime, Sub_metering_3,
          col = "blue")
    legend("topright", lwd = 1, box.lwd = 0,
           col=c("black","blue","red"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  })
  axis(2, at = seq(0,30,by=10),las=2)
  #axis(1, at = seq(0,1200,by=200), las = 2)
  #}
  
  
  # plot3
  #{
  with(df, plot(DateTime, Voltage,
                xlab = "datetime",
                yaxt = "n",
                type = "l"))
  axis(2, at = seq(234,246,by=2),labels = c("234","","238","","242","","246"),las=2)
  #}
  
  # plot4
  #{
  with(df, plot(DateTime, Global_reactive_power,
                xlab = "datetime",
                yaxt = "n",
                type = "l"))
  axis(2,at=seq(0.1,0.5,by=0.1))
}
dev.off()
