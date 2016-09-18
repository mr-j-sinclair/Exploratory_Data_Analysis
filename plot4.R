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


png(filename = "plot4.png")

par(mfrow=c(2,2))

with(data, plot(x=D_T, y=Global_active_power, ylab="Global Active Power", xlab="", type="l"))

with(data, plot(x=D_T, y=Voltage, ylab="Voltage", xlab="datetime", type="l"))

with(data, plot(x=D_T, y=Sub_metering_1, ylab="Energy sub metering", type="l"))

with(data, lines(x=D_T, y=Sub_metering_2, type="l", col="red") )
with(data, lines(x=D_T, y=Sub_metering_3, type="l", col="blue") )
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "blue", "red"))

with(data, plot(x=D_T, y=Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime" ))

dev.off()

