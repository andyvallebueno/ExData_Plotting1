plot4<- function (workingdirectory) {
  
  ## 1. Reading file
  setwd(workingdirectory)
  library(lubridate)
  library(dplyr)
  
  ## 2. Converting Date and Time variables, and filtering for relevant dates
  data<-read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep =";")
  datatb<-tbl_df(data)
  datatb1<-mutate(datatb, Date = dmy(Date), Time = hms(Time))
  data<-data.frame(datatb1)
  
  data1<-subset(data, year(Date) == 2007, Date:Sub_metering_3)
  data1<-subset(data1, month(Date) == 02, select = Date:Sub_metering_3)
  data<-subset(data1, day(Date)<3, select = Date:Sub_metering_3)
  
  ## 3. Joining time and date variables
  Dateslist<-data$Date
  Timeslist<-data$Time
  DateTime<- Dateslist + Timeslist
  
  ## 4. Plot
  png("plot4.png", width=480, height=480)
  par(mfrow=c(2,2), mar = c(4,4,4,4))
  
  ##    Plot 1
  plot(DateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab ="")
  
  ##    Plot 2
  plot(Both, data3$Voltage, ylab = "Voltage", type = "l", xlab ="datetime", cex = 0.8)
  
  ##    Plot 3
  plot(DateTime, data$Sub_metering_1, ylab = "Energy sub metering", type = "n", xlab ="", cex =0.8)
  lines(Both, data$Sub_metering_1)
  lines(Both, data$Sub_metering_2, col="red")
  lines(Both, data$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8, lty = c(1,1,1))
  
  ##    Plot 4
  plot(Both, data3$Global_reactive_power, ylab = "Global_reactive_power", type = "l", xlab ="datetime", cex = 0.8)
  
  dev.off()
  
}