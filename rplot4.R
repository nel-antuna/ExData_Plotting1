#### Setting options

library(tidyverse)
library(readr)
options(max.print = 50)

#### Downloading file

temp <- tempfile(fileext = ".zip")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)

#### Selecting rows to be used during assignment
## I needed to do some checks in order to find out which rows correspond to the correct dates

cols_consumption <- colnames(read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",nrow=2))
consumption <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,col.names=cols_consumption,sep=";")[,1]
conum_dates <- parse_date(consumption,"%d/%m/%Y")
conum_dates1 <- data.frame(conum_dates, seq_along(conum_dates))
cons1 <- conum_dates1 %>%
  filter(conum_dates == "2007-02-01")%>%
  select(2)
cons2 <- conum_dates1 %>%
  filter(conum_dates == "2007-02-02")%>%
  select(2)
max(cons1)-min(cons1)
count(cons1)
max(cons2)-min(cons2)
count(cons2)
head(cons1)
tail(cons1)
head(cons2)
tail(cons2)

#### After checkin which rows contain the data, creating the right object

cols_consumption <- colnames(read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",nrow=2))
consumption <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,col.names=cols_consumption,sep=";", skip=66636, nrows=2880)
consumption$Date <- parse_date(consumption$Date, "%d/%m/%Y")
consumption$Time <- parse_time(consumption$Time, "%H:%M:%S")
head(consumption)
consumption$Datetime <- as.POSIXct(paste(consumption$Date,consumption$Time))

#### Plotting

par(mfcol= c(2,2))

plot(consumption$Datetime,consumption$Global_active_power, type ="l", ylab="Global Active Power (kilowatts)", xlab = "")

plot(consumption$Datetime,consumption$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="", legend = "topright")
lines(consumption$Datetime,consumption$Sub_metering_2, type = "l", col ="red")
lines(consumption$Datetime,consumption$Sub_metering_3, type = "l", col ="blue")
legend("topright", lty=1, box.lty=0,col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(consumption$Datetime, consumption$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(consumption$Datetime, consumption$Global_reactive_power, type="l", ylab= "Blogal_reactive_power", xlab = "datetime")