# load relevant libraries
library(dplyr)

# set the working directory
setwd("~/ExData_Plotting1-master")

# load the dataset
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
data_file <- unzip("household_power_consumption.zip")
hhpc_data <- read.csv(data_file, header = TRUE, sep = ";", stringsAsFactors = FALSE)

# understand the dataset
head(hhpc_data)
summary(hhpc_data)
str(hhpc_data)

# filter the relevant data
hhpc_2days <- hhpc_data[hhpc_data$Date %in% c("1/2/2007","2/2/2007") ,]

# add axis data
datetime <- strptime(paste(hhpc_2days$Date, hhpc_2days$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
hhpc <- cbind(hhpc_2days, datetime)

# recode '?' as NA
hhpc$Global_active_power[hhpc$Global_active_power=='?'] <- NA
hhpc$Global_reactive_power[hhpc$Global_reactive_power=='?'] <- NA
hhpc$Voltage[hhpc$Voltage=='?'] <- NA
hhpc$Global_intensity[hhpc$Global_intensity=='?'] <- NA
hhpc$Sub_metering_1[hhpc$Sub_metering_1=='?'] <- NA
hhpc$Sub_metering_2[hhpc$Sub_metering_2=='?'] <- NA
hhpc$Sub_metering_3[hhpc$Sub_metering_3=='?'] <- NA

# reclass the numeric columns
hhpc$Global_active_power <- as.numeric(hhpc$Global_active_power)
hhpc$Global_reactive_power <- as.numeric(hhpc$Global_reactive_power)
hhpc$Voltage <- as.numeric(hhpc$Voltage)
hhpc$Global_intensity <- as.numeric(hhpc$Global_intensity)
hhpc$Sub_metering_1 <- as.numeric(hhpc$Sub_metering_1)
hhpc$Sub_metering_2 <- as.numeric(hhpc$Sub_metering_2)
hhpc$Sub_metering_3 <- as.numeric(hhpc$Sub_metering_3)

str(hhpc)

#make the plots
png("plot4.png", height = 480, width = 480)

#set the parameters of the device
par(mfrow=c(2,2))

plot(hhpc$datetime, hhpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(hhpc$datetime, hhpc$Voltage, type="l", xlab="datetime", ylab="Voltage")

with(hhpc, plot(datetime,Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")) 
lines(hhpc$datetime, hhpc$Sub_metering_2, col="red", type="l")
lines(hhpc$datetime, hhpc$Sub_metering_3, col="blue", type="l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(hhpc$datetime, hhpc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_powere")

dev.off()
