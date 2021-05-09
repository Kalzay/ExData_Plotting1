library(lubridate)

### Reading in Data ###

# Read data from 1/2/2007 to 2/2/2007 - calculate how many minutes in two days
minutes <- 2 * 24 * 60
data <- read.table("household_power_consumption.txt", header = FALSE, sep=";", na.strings = "?",
                   skip = grep("1/2/2007", readLines("household_power_consumption.txt")), nrows=minutes)

# Read column names and assign to names of data
header <-  read.table("household_power_consumption.txt", header = FALSE, sep=";", na.strings = "?", nrows=1)
colnames(data) <- header[1,]

# Merging date and time columns into DateTime column
data$DateTime <- as.POSIXct(with(data, dmy(Date) + hms(Time)))

#------------------------------------------------------------------------------#

### Plotting ###

# Setting up png
png("plot3.png", width=480, height=480)

with(data, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))

# Adding legend
legend("topright", 
       legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col=c("black", "red", "blue"),
       lty=1, lwd=1)

dev.off()