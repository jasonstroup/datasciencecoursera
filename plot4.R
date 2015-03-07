plot4 <- function() {
  data <- read.table("data/household_power_consumption.txt",sep=";",skip=grep("1/2/2007", readLines("data/household_power_consumption.txt")),nrows=2880,na.strings="?")
  names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  data$DateTime <- strptime(paste(data$Date,data$Time),format= "%d/%m/%Y %H:%M:%S")
  
  png(filename = "plot4.png", width = 480, height = 480, units = "px")
  
  par(mfrow=c(2,2))
  plot(data$DateTime, data$Global_active_power, type ="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(data$DateTime, data$Voltage, type ="l", xlab="datetime", ylab="Voltage")
  
  plot(data$DateTime, data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
  lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
  lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1)
  
  plot(data$DateTime, data$Global_reactive_power, type ="l", xlab="datetime", ylab="Global_reactive_power")
  
  dev.off()
}