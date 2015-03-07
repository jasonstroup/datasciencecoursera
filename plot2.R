plot2 <- function() {
  data <- read.table("data/household_power_consumption.txt",sep=";",skip=grep("1/2/2007", readLines("data/household_power_consumption.txt")),nrows=2880,na.strings="?")
  names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  data$DateTime <- strptime(paste(data$Date,data$Time),format= "%d/%m/%Y %H:%M:%S")
  
  png(filename = "plot2.png", width = 480, height = 480, units = "px")
  
  plot(data$DateTime, data$Global_active_power, type ="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  dev.off()
}