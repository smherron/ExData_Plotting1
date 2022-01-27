## Electric Power Consumption Exploratory Graphs

##  Overall goal is to examine how household energy usage varies over a 2 day
##  period in February 2007. Since it was unspecified as to which days, 
##  I chose Feb 1-2, 2007.

## plot1: Create histogram of global active power

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
summary(dataset)

## Adding columns that separates the column "Date" by dotw, mth, yr, day
## Change appropriate columns to be numeric.
library(lubridate)
dataset$wday <- wday(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$month <- month(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$year <- year(dmy(dataset$Date))
dataset$day <- day(dmy(dataset$Date))
n <- c(3, 4, 5, 6, 7, 8, 9)
dataset[ , n] <- sapply(dataset[ , n], as.numeric)
summary(dataset)

## Creating new set with only data from Feb 1-2, 2007
feb <- subset(dataset, month == "Feb" & year == 2007 & day <= 2)
feb$hour <- strptime(paste(feb$Date, feb$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
head(feb)
summary(feb)

## Create histogram with labels
png("plot1.png", width = 480, height = 480, bg = NA)
hist(feb$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()




