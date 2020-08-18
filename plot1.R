library(tidyverse)
library(readr)
options(max.print = 50)
temp <- tempfile(fileext = ".zip")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
cols_consumption <- colnames(read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",nrow=2))
consumption <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,col.names=cols_consumption,sep=";")[,1]
conum_dates <- parse_date(consumption,"%d/%m/%Y")
conum_dates1 <- data.frame(conum_dates, seq_along(conum_dates))
conum_dates1 %>%
  filter(conum_dates %in% c("2007-02-01", "2007-02-02"))
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
consumption <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,col.names=cols_consumption,sep=";", skip=66636, nrows=2880)
head(consumption)
table(consumption$Date)
