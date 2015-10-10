## File: plot1.R
## Author: James A. Crotinger [JAC]
## Date: 10-October-15

## This script reads the "Household Power Consumption" dataset and makes
## "Plot 1" for the Coursera "Exploratory Data Analysis" Course Project 1.

## This script expects that dataset to be in the text file
## "household_power_consumption.txt" in the parent directory.

df <- read.table("../household_power_consumption.txt",
                 sep = ';',
                 na.strings = c("?",""),  # '?' and empty columns yield NAs
                 stringsAsFactors = F,
                 header=T)

df$Date_time = strptime(paste(df$Date, df$Time), format='%d/%m/%Y %H:%M:%S')

df$Date = as.Date(df$Date, format = '%d/%m/%Y')

dates = as.Date(c("2007-02-01", "2007-02-02"))

df.filt = df[df$Date %in% dates,]

png(file='plot1.png', width=480, height=480)

with (df.filt,
      hist(Global_active_power,
      main='Global Active Power',
      xlab='Global Active Power (kilowatts)',
      col='red')
)

dev.off()
