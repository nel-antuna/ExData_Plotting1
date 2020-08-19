library(tidyverse)
library(readr)
options(max.print = 50)
temp <- tempfile(fileext = ".zip")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
cols_consumption <- colnames(read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",nrow=2))
consumption <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,col.names=cols_consumption,sep=";", skip=66636, nrows=2880)
consumption$Date <- parse_date(consumption$Date, "%d/%m/%Y")
consumption$Time <- parse_time(consumption$Time, "%H:%M:%S")
head(consumption)
consumption$Datetime <- as.POSIXct(paste(consumption$Date,consumption$Time))

par(mfcol= c(2,2))
plot(consumption$Datetime,consumption$Global_active_power, type ="l", ylab="Global Active Power (kilowatts)", xlab = "")

plot(consumption$Datetime,consumption$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", legend = "topright")
lines(consumption$Datetime,consumption$Sub_metering_2, type = "l", col ="red")
lines(consumption$Datetime,consumption$Sub_metering_3, type = "l", col ="blue")
legend("topright", lty=1, box.lty=0,col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(consumption$Datetime, consumption$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(consumption$Datetime, consumption$Global_reactive_power, type="l", ylab= "Blogal_reactive_power", xlab = "datetime")
