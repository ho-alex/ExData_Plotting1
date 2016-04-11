library(data.table)

#Exploratory Data Analysis
#Course Project 1
#Plot 4

# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#   
#   Date: Date in format dd/mm/yyyy
#   Time: time in format hh:mm:ss
#   Global_active_power: household global minute-averaged active power (in kilowatt)
#   Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#   Voltage: minute-averaged voltage (in volt)
#   Global_intensity: household global minute-averaged current intensity (in ampere)
#   Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#       It corresponds to the kitchen, containing mainly a dishwasher, an oven and a 
#       microwave (hot plates are not electric but gas powered).
#   Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#       It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#   Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#       It corresponds to an electric water-heater and an air-conditioner.

# filename: household_power_consumption.txt

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=2075259, colClasses = "character")

## Data currently codes NA as "?". Replaces all instances of "?" with NA
df[df=="?"] <- NA

# convert first column into "Date" class
df[,1] <-as.Date(df[,1], "%d/%m/%Y")

# convert third to ninth columns into numeric
df[,3] <-as.numeric(df[,3])
df[,4] <-as.numeric(df[,4])
df[,5] <-as.numeric(df[,5])
df[,6] <-as.numeric(df[,6])
df[,7] <-as.numeric(df[,7])
df[,8] <-as.numeric(df[,8])
df[,9] <-as.numeric(df[,9])

# subset data to grab only dates 2007-02-01 and 2007-02-02
mysubdf <- subset(df, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# create datetime object for date + time
mydatetime <- as.POSIXct(paste(mysubdf$Date, mysubdf$Time), format="%Y-%m-%d %H:%M:%S")

# Open PNG graphic device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

# Generate the line plot (plot 4)
# 2x2 array f plots:
# (1,1) = global active power vs. mydatetime
# (1,2) = voltage vs. mydatetime
# (2,1) = energy sub metering vs. mydatetime
# (2,2) = global reactive power vs. mydatetime

par(mfrow=c(2,2))
plot(mydatetime, mysubdf$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(mydatetime, mysubdf$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(mydatetime,mysubdf$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
par(new=T)
lines(mydatetime, mysubdf$Sub_metering_2, type = "l", col="red")
lines(mydatetime, mysubdf$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
par(new=F)
plot(mydatetime,mysubdf$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()