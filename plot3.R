initial <- read.table("household_power_consumption.txt", header = TRUE,sep=";",stringsAsFactors = FALSE,nrows = 10)
classes <- sapply(initial, class)
tabAll=read.table("household_power_consumption.txt",sep=";", header = TRUE,na.strings='?',stringsAsFactors = FALSE,colClasses =classes)

tabAll[,1]<- as.Date(tabAll[,1],format="%d/%m/%Y")
projectdata <- subset(tabAll, tabAll$Date >=as.Date("2007-02-01")  ,select=c(Date,Global_active_power,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3))
projectdata <- subset(projectdata, projectdata$Date <=as.Date("2007-02-02"))
projectdata <- transform(projectdata, time2=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


with(projectdata, {
  plot(Sub_metering_1 ~ time2, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ time2, col = 'Red')
  lines(Sub_metering_3 ~ time2, col = 'Blue')
})
#The plot shows the x-axis with my locale arabic, so it is not in english but it is the same thursday,friday,saturday
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
