# setting the working directory
setwd("~/ExData_Plotting1-master")

# loading the dataset
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
data_file <- unzip("household_power_consumption.zip")
hhpc_data <- read.csv(data_file, header = TRUE, sep = ";")

# understanding the dataset
head(hhpc_data)
summary(hhpc_data)


