## Preparation and retrieving data
workpath <- "exdata-016/p1"
currwd <- getwd()

Sys.setlocale("LC_ALL", 'US') #prevent labels in plots from showing up in Dutch or any other language

if (!file.exists(workpath)) dir.create(workpath, recursive=T)

setwd(workpath)

if (!file.exists("household_power_consumption.txt")) {
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="exdata-016-p1.zip")
        unzip("exdata-016-p1.zip")
}

pcn <- subset(read.csv("household_power_consumption.txt", 
                       sep=";", na.strings="?", 
                       colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
                       ),
              Date %in% c("1/2/2007","2/2/2007")
              )
pcn$Time <- strptime(paste(pcn$Date, pcn$Time),format="%d/%m/%Y %H:%M:%S")
pcn$Date <- as.Date(pcn$Date,format="%d/%m/%Y")


## creating plot
png("plot2.png")
plot(pcn$Time, pcn$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## reset wd to what it originally was
setwd(currwd)

