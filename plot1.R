#this code will create necessary folder and then download the dataset from web. After downloading the file it will unzip the file 

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
                         
#This part will create the histogram for global active power
                         
png("C://Users/souvi/Documents/coursera/week1 course project1/plot1.png")
hist(useful_data$`Global active power` , main="Global Active Power", col="red",xlab = "Global Active Power(KW)")
dev.off()

