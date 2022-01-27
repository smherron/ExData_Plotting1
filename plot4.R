## Electric Power Consumption Exploratory Graphs

##  Overall goal is to examine how household energy usage varies over a 2 day
##  period in February, 2007

## plot3 goal: graph all 3 submetering during Feb 1-2, 2007

## Import file
file_name <- "Electric Power Consumption.zip"
if (!file.exists(file_name)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, file_name, method = "curl") 
}
if (!file.exists("household_power_consumption.txt")) {
  unzip(file_name)
}

dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
head(dataset)


## Adding columns that separates the column "Date" by dotw, mth, yr, day
## Change appropriate columns to be numeric.
library(lubridate)
dataset$wday <- wday(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$month <- month(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$year <- year(dmy(dataset$Date))
dataset$day <- day(dmy(dataset$Date))
dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
dataset$Global_reactive_power <- as.numeric(dataset$Global_reactive_power)
dataset$Voltage <- as.numeric(dataset$Voltage)
dataset$Global_intensity <- as.numeric(dataset$Global_intensity)
dataset$Sub_metering_1 <- as.numeric(dataset$Sub_metering_1)
dataset$Sub_metering_2 <- as.numeric(dataset$Sub_metering_2)
dataset$Sub_metering_3 <- as.numeric(dataset$Sub_metering_3)
summary(dataset)

## Creating new set with only data from Feb 1-2, 2007 and create a new column with date and time
feb <- subset(dataset, month == "Feb" & year == 2007 & day <= 2)
feb$hour <- strptime(paste(feb$Date, feb$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
head(feb)
summary(feb)


## Create base for multiple plots and set margins
png("plot4.png", width = 480, height = 480, bg = NA)
par(mfrow = c(2, 2), mar = c(2, 4, 2, 2), oma = c(1, 1, 2, 0))
## GAP graph
plot(feb$hour, feb$Global_active_power, 
     type = "l",
     ylab = "Global Active Power", xlab = "")
## Voltage graph
plot(feb$hour, feb$Voltage,
     type = "l",
     ylab = "Voltage", xlab = "")
## Using plot3
plot(feb$hour, feb$Sub_metering_1, type = "n",
     xlab = "",
     ylab = "Energy Sub Metering")
lines(feb$hour, feb$Sub_metering_1)
lines(feb$hour, feb$Sub_metering_2, col = "red")
lines(feb$hour, feb$Sub_metering_3, col = "blue")
legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))
## GRP graph
plot(feb$hour, feb$Global_reactive_power,
     type = "l",
     ylab = "Global Reactive Power", xlab = "")
## Add title
mtext("February 1 - 2, 2007", outer = TRUE)

dev.off() 


