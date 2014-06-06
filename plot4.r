library(lubridate)
data  <-  read.table("household_power_consumption.txt", sep = ";", 
                     col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                                 "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), stringsAsFactors=FALSE)

data        <-  data[-1,]
data$Date   <-  as.Date(dmy(data$Date))  

date1       <-  as.Date("2007-02-01")
date2       <-  as.Date("2007-02-02")
date.usable <-  c(date1, date2)
data.usable <-  subset(data, (Date %in% date.usable))

data.usable$Global_active_power   <-  as.numeric(data.usable$Global_active_power)
data.usable$DateTime <- paste(data.usable$Date, data.usable$Time)

data.usable$DateTime <- ymd_hms(data.usable$DateTime)

png(file = "plot4.png")
par(mfrow = c(2,2))
plot(data.usable$DateTime, data.usable$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(data.usable$DateTime, data.usable$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data.usable$DateTime, data.usable$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", col = "black")
lines(data.usable$DateTime, data.usable$Sub_metering_1, type = "l", col = "black")
lines(data.usable$DateTime, data.usable$Sub_metering_2, type = "l", col = "red")
lines(data.usable$DateTime, data.usable$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black","red", "blue"))
plot(data.usable$DateTime, data.usable$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
