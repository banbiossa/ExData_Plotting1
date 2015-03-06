## set path for file
path <- "/Users//shota/R/exploratory_data_analysis///data//household_power_consumption.txt"

## read data for 01/02/2007 and 02/02/2007
data <- read.csv(path,skip=66636,header=TRUE,nrows=2880,sep=";")

## get names from header
names <- read.csv(path,nrows=1,header=FALSE,sep=";")
names(data) <- sapply(names,as.character)

## convert Date and Time
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date,data$Time), "%Y-%d-%m %H:%M:%S")

## make the plots
library(ggplot2)

#qplot(Global_active_power,data=data,fill="red")
g <- ggplot(data,aes(Global_active_power))
g <- g + 
        geom_histogram(fill="red",binwidth=0.5,col="black") +
        labs(x="Global Active Power (kilowatts)") + 
        labs(y="Frequency") + 
        labs(title="Global Active Power") +
        theme(plot.title = element_text(face="bold")) +
        xlim(0,6) + 
        ylim(0,1300) + 
        scale_y_continuous(breaks = seq(0, 1200, 200))+
        theme_bw() +
        theme(
                plot.background = element_blank()
                ,panel.grid.major = element_blank()
                ,panel.grid.minor = element_blank()
                ,panel.border = element_blank()
        ) +
        theme(axis.line = element_line(color = 'black'))
print(g)

dev.copy(png,file="/Users//shota/git//ExData_Plotting1/plot1.png")
dev.off()