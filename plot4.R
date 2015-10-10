## File: plot4.R
## Author: James A. Crotinger [JAC]
## Date: 10-October-15

## This script reads the "Household Power Consumption" dataset and makes
## "Plot 4" for the Coursera "Exploratory Data Analysis" Course Project 1.

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

png(file='plot4.png', width=480, height=480)

par(mfcol=c(2,2))

# Copied from plot2.R, but no '(kilowatts)' in the y label...

with(df.filt,
     plot(Date_time, Global_active_power,
          type='l',
          xlab='',
          ylab='Global Active Power')
)

# Copied from plot3.R, but no box around the legend...

ymin = min(df.filt$Sub_metering_1, df.filt$Sub_metering_2, df.filt$Sub_metering_3)
ymax = max(df.filt$Sub_metering_1, df.filt$Sub_metering_2, df.filt$Sub_metering_3)
ylimits = c(ymin, ymax)

with(df.filt,
     plot(Date_time, Sub_metering_1,
          type='l',
          col='black',
          ylim=ylimits,
          xlab='',
          ylab='Energy sub metering')
)

par(new=T)

with(df.filt,
     plot(Date_time, Sub_metering_2,
          type='l',
          col='red',
          ylim=ylimits,
          xlab='',
          ylab='',
          xaxt='n',
          yaxt='n')
)

par(new=T)

with(df.filt,
     plot(Date_time, Sub_metering_3,
          type='l',
          col='blue',
          ylim=ylimits,
          xlab='',
          ylab='',
          xaxt='n',
          yaxt='n')
)

legend("topright",
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'),
       lty=1,
       bty='n')

with(df.filt,
     plot(Date_time, Voltage, xlab='datetime', ylab='Voltage', type='l')
     )

with(df.filt,
     plot(Date_time, Global_reactive_power, xlab='datetime', ylab='Global_reactive_power', type='l')
)

dev.off()

