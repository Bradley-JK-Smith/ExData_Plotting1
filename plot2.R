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

png('plot2.png', width = 480, height = 480)
plot(x$datetime, x$Global_active_power,
     type = 'l',
     xlab = NA,
     ylab = 'Global Active Power (kilowatts)')
dev.off()

