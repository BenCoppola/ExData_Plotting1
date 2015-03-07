#clear the environment
rm(list=ls())

#change the working directory
setwd('C:/Users/coppab01/Documents/Coursera/Exploratory Data Analysis/Project 1')

# load up useful packages
library(dplyr)


tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep=";")
classes <- sapply(tab5rows, class)
tabAll <- read.table("household_power_consumption.txt", header = TRUE, colClasses = classes, nrows = 2075259, na.strings = "?", sep=";")
tabAll <- tbl_df(tabAll)

#combine date and time strings
tabAll <- mutate(tabAll, DateTime = paste(Date, Time))

#convert "DateTime" string to POSIXct class and "Date" to Date class
tabAll$DateTime <- as.POSIXct(strptime(tabAll$DateTime, "%d/%m/%Y %H:%M:%S")) 
tabAll$Date <- as.Date(tabAll$Date, "%d/%m/%Y")

#filter to the 2 days in question
data <- filter(tabAll, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

#make Plot 3
ylimits <- with(data, range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)))
png(filename = "plot3.png", width = 480, height = 480, type="windows")
with(data, plot(DateTime, Sub_metering_1, type = "n", 
        axes = FALSE, xlab = "", ylab = "", ylim = ylimits))
lines(data$DateTime, data$Sub_metering_1, col="black")
par(new=TRUE) #similar to 'hold on' in MATLAB
with(data, plot(DateTime, Sub_metering_2, type = "n", 
        axes = FALSE, xlab = "", ylab = "", ylim = ylimits))
lines(data$DateTime, data$Sub_metering_2, col="red")
par(new=TRUE)
with(data, plot(DateTime, Sub_metering_3, type = "n", 
     ylim = ylimits,
     ylab = "Energy sub metering", xlab = ""))
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", # places a legend at the appropriate place 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # puts text in the legend 
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       col=c("black", "red", "blue")) # gives the legend lines the correct color and width
dev.off()