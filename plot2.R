#Preparing the Data Set
#Loading the data set from directory & subset for specified dates (EPC=Electric Power Consumption Data)
EPC <- data.table::fread(input="household_power_consumption.txt"
                         , na.strings="?"
)

#Prevent Scientific Notation
EPC[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Preparing the Plot 2
#Making a POSIXct date to be filtered and graphed by time of day
EPC [, dateTime:=as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]

#Filter Dates for 2007-02-01 and 2007-02-02
EPC <- EPC[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

#Saving Plot 2
png("plot2.png",width=480,height=480)

##Plot 2
plot(x = EPC[, dateTime]
     , y = EPC[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()