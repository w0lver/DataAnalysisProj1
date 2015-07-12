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
##Create Plot4
par(mfrow=c(2,2))
plot(reducedData$datetime, reducedData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(reducedData$datetime, reducedData$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(reducedData$datetime, reducedData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(reducedData$datetime, reducedData$Sub_metering_2, col="red")
lines(reducedData$datetime, reducedData$Sub_metering_3, col="blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
plot(reducedData$datetime, reducedData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
