#Preparing the Data Set
#Loading the data set from directory & subset for specified dates (EPC=Electric Power Consumption Data)
EPC <- data.table::fread(input="household_power_consumption.txt"
                         , na.strings="?"
)

#Prevent Scientific Notation
EPC[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Preparing the Plot 3
#Making a POSIXct date to be filtered and graphed by time of day
EPC [, dateTime:=as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]

#Filter Dates for 2007-02-01 and 2007-02-02
EPC <- EPC[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Saving Plot 3
png("plot3.png",width=480,height=480)

#Plot 3
plot(EPC[, dateTime], EPC[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(EPC[, dateTime], EPC[, Sub_metering_2],col="red")
lines(EPC[, dateTime], EPC[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()