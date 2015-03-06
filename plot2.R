## set path for file
path <- "/Users//shota/R/exploratory_data_analysis///data//household_power_consumption.txt"

## read data for 01/02/2007 and 02/02/2007
data <- read.csv(path,skip=66636,header=TRUE,nrows=2880,sep=";")

## get names from header
names <- read.csv(path,nrows=1,header=FALSE,sep=";")
names(data) <- sapply(names,as.character)

## convert Date and Time
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

## make the plots
library(ggplot2)
library(scales)

g <- ggplot(data,aes(Time,Global_active_power))
g <- g +geom_line() + 
        theme_bw() +
        theme(
                plot.background = element_blank()
                ,panel.grid.major = element_blank()
                ,panel.grid.minor = element_blank()
        ) +
        scale_x_datetime(breaks="1 day",
                         labels=date_format(c("Sat","Thu","Fri")))+
        labs(y="Global Active Power (kilowatts)")+
        labs(x="")
        
        

print(g)
dev.copy(png,file="/Users//shota/git//ExData_Plotting1/plot2.png")
dev.off()