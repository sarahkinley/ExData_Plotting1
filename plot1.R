#Preparing the Data Set
#Loading the data set from directory & subset for specified dates (EPC=Electric Power Consumption Data)
EPC <- data.table::fread(input="household_power_consumption.txt"
                         , na.strings="?"
)

#Prevent Scientific Notation
EPC[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Preparing Plot 1
#Change Date Column to Date Type
EPC[,Date:=lapply(.SD,as.Date,"%d/%m/%Y"),.SDcols=c("Date")]

#Filter Dates for 2007-02-01 and 2007-02-02
EPC <- EPC[(Date>="2007-02-01")&(Date<="2007-02-02")]

#Saving Plot 1
png("plot1.png",width=480,height=480)

#Plot 1
hist(EPC[,Global_active_power], main="Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frequency",col="Red")

dev.off()