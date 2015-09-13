# Explorattory Data Analysis Project 1 Plot 1.R
# 
# Amit Gautam
# Sept 2015
# Project 1 for Exploratory Data Analysis
##############################################################################################
##  Initial Setup: Download data files if necessary.            
##############################################################################################

## install the required packages
packages <- c("dplyr", "tidyr","lubridate")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

library(dplyr)
library(tidyr)
library(lubridate)

# set the current working directory to the project directory.  
# change as neeeded to match your project directory
# or remove the line to use the current working directory.
#setwd("~/Data Science Specialization/Exploratory Analysis")

# set the data subdirectory path
dataPath <- file.path("./data")

# create the data subdirectory if it doesn't exist.
if(!file.exists(dataPath)){dir.create(dataPath)}

# if the zip archive with the data files doesn't exist already, download it 
zipfileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfileDownload <- file.path(dataPath, "exdata_data_household_power_consumption.zip")
if(!file.exists(zipfileDownload)) {download.file(zipfileURL,destfile=zipfileDownload)}

# Unzip all the files. They will be placed in the "/UCI HAR Dataset"
# subdirectory of the data subdirectory this will overwrite any data files that
# were previously unzipped
unzip(zipfile=zipfileDownload,exdir=dataPath)
hhpwrcons_dataPath <- file.path(dataPath, "household_power_consumption")

X_test <- read.table(file.path("./data/household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE )

data <- tbl_df(X_test)

data <- mutate(data, Date = dmy(Date), datetime = as.POSIXct(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S"), Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage),
               Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), 
               Sub_metering_3 = as.numeric(Sub_metering_3))

sampledata <- filter(data, Date >= ymd("2007-02-01"), Date <= ymd("2007-02-02"))

png(file = "Plot1.png", width = 480, height = 480)
par(mfrow = c(1,1))
hist(sampledata$Global_active_power, col = "orange", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()


