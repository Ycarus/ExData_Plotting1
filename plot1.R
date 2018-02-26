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

# clean and reformat the data

# reclass the Date column and Time column
hhpc_data$Date <- as.Date(hhpc_data$Date, "%d/%m/%Y")
hhpc_data$Time <- as.POSIXct(strptime(hhpc_data$Time, "%H:%M:%S"))

# recode '?' as NA
hhpc_data$Global_active_power[hhpc_data$Global_active_power=='?'] <- NA
hhpc_data$Global_reactive_power[hhpc_data$Global_reactive_power=='?'] <- NA
hhpc_data$Voltage[hhpc_data$Voltage=='?'] <- NA
hhpc_data$Global_intensity[hhpc_data$Global_intensity=='?'] <- NA
hhpc_data$Sub_metering_1[hhpc_data$Sub_metering_1=='?'] <- NA
hhpc_data$Sub_metering_2[hhpc_data$Sub_metering_2=='?'] <- NA
hhpc_data$Sub_metering_3[hhpc_data$Sub_metering_3=='?'] <- NA

# reclass the numeric columns
hhpc_data$Global_active_power <- as.numeric(hhpc_data$Global_active_power)
hhpc_data$Global_reactive_power <- as.numeric(hhpc_data$Global_reactive_power)
hhpc_data$Voltage <- as.numeric(hhpc_data$Voltage)
hhpc_data$Global_intensity <- as.numeric(hhpc_data$Global_intensity)
hhpc_data$Sub_metering_1 <- as.numeric(hhpc_data$Sub_metering_1)
hhpc_data$Sub_metering_2 <- as.numeric(hhpc_data$Sub_metering_2)
hhpc_data$Sub_metering_3 <- as.numeric(hhpc_data$Sub_metering_3)

str(hhpc_data)

# filter the relevant data
hhpc_2days <- filter(hhpc_data, Date >= "2007-02-01" &  Date <= "2007-02-02")

#make the plots
png("plot1.png", height = 480, width = 480)
hist(hhpc_2days$Global_active_power, breaks = 12, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)" )
dev.off()
