initial <- read.table("household_power_consumption.txt", header = TRUE,sep=";",stringsAsFactors = FALSE,nrows = 10)
classes <- sapply(initial, class)
tabAll=read.table("household_power_consumption.txt",sep=";", header = TRUE,na.strings='?',stringsAsFactors = FALSE,colClasses =classes)

tabAll[,1]<- as.Date(tabAll[,1],format="%d/%m/%Y")
projectdata <- subset(tabAll, tabAll$Date >=as.Date("2007-02-01")  ,select=c(Date,Global_active_power,Time))
projectdata <- subset(projectdata, projectdata$Date <=as.Date("2007-02-02"))
projectdata <- transform(projectdata, time2=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


plot(projectdata$time2,projectdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
#The plot shows the x-axis with my locale arabic, so it is not in english but it is the same thursday,friday,saturday
 
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

 