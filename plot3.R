plot3<- function (workingdirectory) {
  
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
  plot(DateTime, data$Sub_metering_1, ylab = "Energy sub metering", type = "n", xlab ="", cex =0.8)
  lines(Both, data$Sub_metering_1)
  lines(Both, data$Sub_metering_2, col="red")
  lines(Both, data$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8, lty = c(1,1,1))
  
  ## 5. Save plot to PNG
  
  dev.copy(png, file = "plot3.png")
  dev.off()
  
}