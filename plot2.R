## Pulls full dataset ; delimited 
fullData <- read.table("household_power_consumption.txt", header = TRUE, sep = ';')
##convert field to date so data can subset based on range
fullData$Date <- as.Date(fullData$Date, format="%d/%m/%Y")
## reduce to only include 2007-02-01 and 2007-02-02
reducedData <- subset(fullData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
## concatentate date and time into single variable
reducedData$datetime = paste(reducedData$Date, reducedData$Time)
## convert to datatime data type
reducedData$datetime <- as.POSIXct(reducedData$datetime)
##reduce percision 
reducedData$Global_active_power <- as.numeric(reducedData$Global_active_power) / 1000
## Plot 2
par(mar=c(2,4,1,2)) 
plot(reducedData$Global_active_power~reducedData$datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
## Saves plot to file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off() 