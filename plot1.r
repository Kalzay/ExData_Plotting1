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
png("plot1.png", width=480, height=480)

hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()