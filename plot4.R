## set path for file
path <- "/Users//shota/R/exploratory_data_analysis///data//household_power_consumption.txt"
library(ggplot2)
library(scales)
library(grid)
library(gridExtra)

## read data for 01/02/2007 and 02/02/2007
data <- read.csv(path,skip=66636,header=TRUE,nrows=2880,sep=";")

## get names from header
names <- read.csv(path,nrows=1,header=FALSE,sep=";")
names(data) <- sapply(names,as.character)

## convert Date and Time
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

## make the plots

g1 <- ggplot(data,aes(Time,Global_active_power)) +
        geom_line() + 
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

g2 <- ggplot(data,aes(x=Time))+
        geom_line(aes(y=Sub_metering_1,color="Sub_metering_1"))+
        geom_line(aes(y=Sub_metering_2,color="Sub_metering_2"))+
        geom_line(aes(y=Sub_metering_3,color="Sub_metering_3"))+
        labs(color="")+
        scale_color_manual("",
                           breaks=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                           values=c("black","red","blue"))+
        theme_bw()+
        theme(
                plot.background = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                legend.position = c(.7,.8),
                legend.key = element_blank(),
                legend.background= element_blank()
        ) +
        theme(axis.line = element_line(color = 'black')) +
        scale_x_datetime(breaks="1 day",
                         labels=date_format(c("Sat","Thu","Fri")))+
        labs(x="") + 
        labs(y="Energy sub metering")

g3 <- ggplot(data,aes(x=Time,y=Voltage)) + 
        geom_line() + 
        theme_bw()+
        theme(
                plot.background = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank()
        ) +
        theme(axis.line = element_line(color = 'black')) +
        scale_x_datetime(breaks="1 day",
                         labels=date_format(c("Sat","Thu","Fri")))+
        labs(x="datetime") + 
        scale_y_continuous(breaks=seq(234,246,2),
                           labels=c(234,"",238,"",242,"",246))

g4 <- ggplot(data,aes(x=Time,y=Global_reactive_power)) + 
        geom_line()+
        theme_bw()+
        theme(
                plot.background = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank()
        ) +
        theme(axis.line = element_line(color = 'black')) +
        scale_x_datetime(breaks="1 day",
                         labels=date_format(c("Sat","Thu","Fri")))+
        labs(x="datetime")


#multiplot(g1,g2,g3,g4,rows=2)
grid.arrange(g1,g3,g2,g4,ncol=2)
dev.copy(png,file="/Users//shota/git//ExData_Plotting1/plot4.png")
dev.off()