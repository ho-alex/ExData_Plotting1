library(data.table)

#Exploratory Data Analysis
#Course Project 1
#Plot 1

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

# Open PNG graphic device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

# Generate the histogram (plot 1)
hist(mysubdf$Global_active_power, xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", col="red", main = "Global Active Power")

dev.off()