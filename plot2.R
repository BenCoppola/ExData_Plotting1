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

#make Plot 2
png(filename = "plot2.png", width = 480, height = 480, type="windows")
plot(data$DateTime, data$Global_active_power, type = "n", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(data$DateTime, data$Global_active_power)
dev.off()