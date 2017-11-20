library(lubridate)
if(!dir.exists("C://Users/souvi/Documents/coursera/data_source")){dir.create("C://Users/souvi/Documents/coursera/data_source")}
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"C://Users/souvi/Documents/coursera/data_source/household_data.zip")
unzip("C://Users/souvi/Documents/coursera/data_source/household_data.zip",exdir = "C://Users/souvi/Documents/coursera/data_source")

 #This part will load the data into R and pick out the dataset only for 2/2/2007 and 2/1/2007 and cleanup the dataset little. Then it will remove
# the full dataset  

full_data<- read.table("C://Users/souvi/Documents/coursera/data_source/household_power_consumption.txt",sep = ";",header = T)
useful_data<-subset(full_data,Date=="1/2/2007"|Date=="2/2/2007")
useful_data<-mutate(useful_data,Date=as.Date(Date,format="%d/%m/%Y"))
useful_data[3:8]<-sapply(useful_data[3:8], function(x) as.numeric(levels(x)[x]))
names(useful_data)<-gsub("_"," ",names(useful_data))
rm("full_data")
                         
 # This part will plot the necessary data in one graph
                         
useful_data<-mutate(useful_data, datetime=paste(Date,Time))
useful_data$datetime<-ymd_hms(useful_data$datetime)
png("C://Users/souvi/Documents/coursera/week1 course project1/plot4.png")
par(mfrow=c(2,2))
with(useful_data,plot(datetime,`Global active power`,type = "l",xlab="",ylab="Global Active Power (kilowatts)"))
with(useful_data,plot(datetime,Voltage,type = "l"))
plot(useful_data$datetime,useful_data$`Sub metering 1`,type = "l",ylab="Energy Submetering", xlab="")
lines(useful_data$datetime,useful_data$`Sub metering 2`,type = "l",col="red")
lines(useful_data$datetime,useful_data$`Sub metering 3`,type = "l",col="blue")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
with(useful_data,plot(datetime,`Global reactive power`,type = "l",ylab="Global reactive Power (kilowatts)"))
dev.off()
