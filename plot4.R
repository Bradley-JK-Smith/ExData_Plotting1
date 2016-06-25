# Get the table
# Be careful because 'skip' jumps over all the lines
# and so is much faster but this means the header
# line is also skipped so needs to be got separately

x <- read.table('household_power_consumption.txt',
                colClasses = c('character', 'character', rep('numeric',7) ),
                header=FALSE,
                sep = ';',
                skip = 66637,
                nrows = 2880,
                na.strings='?',
                stringsAsFactors = FALSE)
y <- read.table('household_power_consumption.txt',
                sep = ';',
                nrows=1,
                stringsAsFactors = FALSE)
colnames(x) <- y[1,]
x$datetime <- as.POSIXlt(paste(x$Date, x$Time), format='%d/%m/%Y %H:%M:%S')

# Group of 4 plots
png('plot4.png', width = 480, height = 480)

par(mfrow = c(2,2) )

# Top-left plot
plot(x$datetime, x$Global_active_power,
     type = 'l',
     xlab = NA,
     ylab = 'Global Active Power')

# Top-right plot
plot(x$datetime, x$Voltage,
     type = 'l',
     xlab = 'datetime',
     ylab = 'Voltage')

# Bottom-left plot
plot(x$datetime, x$Sub_metering_1,
     type = 'l',
     col  = 'black',
     xlab = NA,
     ylab = 'Energy sub metering')
lines(x$datetime, x$Sub_metering_2, col='red')
lines(x$datetime, x$Sub_metering_3, col='blue')
legend('topright',
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty = 1,
       bty='n',
       col = c('black', 'red', 'blue'))

# Bottom-right plot
plot(x$datetime, x$Global_reactive_power,
     type = 'l',
     xlab = 'datetime',
     ylab = 'Global_reactive_power')
dev.off()
