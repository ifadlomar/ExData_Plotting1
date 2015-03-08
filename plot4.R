
initial <- read.table("household_power_consumption.txt", header = TRUE,sep=";",stringsAsFactors = FALSE,nrows = 10)
classes <- sapply(initial, class)
tabAll=read.table("household_power_consumption.txt",sep=";", header = TRUE,na.strings='?',stringsAsFactors = FALSE,colClasses =classes)

tabAll[,1]<- as.Date(tabAll[,1],format="%d/%m/%Y")
projectdata <- subset(tabAll, tabAll$Date >=as.Date("2007-02-01")  ,select=c(Date,Global_active_power,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3,Voltage,Global_reactive_power))
projectdata <- subset(projectdata, projectdata$Date <=as.Date("2007-02-02"))
projectdata <- transform(projectdata, time2=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")





par(mfrow=c(2,2))
#  plots show the x-axis with my locale arabic, so it is not in english but it is the same thursday,friday,saturday

plot(projectdata$time2,projectdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
 
plot(projectdata$time2,projectdata$Voltage, type="l", xlab="datetime", ylab="Voltage")

 
plot(projectdata$time2,projectdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(projectdata$time2,projectdata$Sub_metering_2,col="red")
lines(projectdata$time2,projectdata$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) 
plot(projectdata$time2,projectdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
