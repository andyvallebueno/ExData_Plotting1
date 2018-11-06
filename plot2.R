plot2<- function (workingdirectory) {
  
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
  
  ## 4. Plot & save plot
  png("plot2.png", width=480, height=480)
  plot(DateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab ="")
  dev.off()
  
}