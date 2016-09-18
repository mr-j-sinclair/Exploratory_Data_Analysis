## Read in data from Zip folder
zip_folder <- "exdata_data_household_power_consumption.zip"

raw_data_file <- "household_power_consumption.txt"

data <- read.table(unz(zip_folder, raw_data_file), header=T, na.strings = "?", sep = ";")

## Convert Date column to R's Date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")


## remove all rows that do NOT correspond to correct dates
## 2007-02-01 && 2007-02-02

data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

## Create date time variable "D_T"    

data$D_T <- as.POSIXlt(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

## Make Plots :)

png(filename = "plot1.png")

with(data, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)" ))#

dev.off()