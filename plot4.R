if(file.exists("household_power_consumption.txt")){
    if(!require("dplyr"))
    {
        message("dplyr package required and not found, Installing dplyr package ... ")
        install.packages("dplyr")
        library("dplyr")
    }
    if(require("dplyr"))
    {
        message("Reading the household_power_consumption.txt file ...")
        mydata <- tbl_df(read.csv("household_power_consumption.txt",nrow=2075259,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),sep=";", na.strings="?", stringsAsFactors=FALSE))
        mydata <- mutate(mydata,Date=as.Date(Date,format="%d/%m/%Y"))
        message("Extracting the required subset ...")
        myExData <- filter(mydata,Date=='2007-02-01' | Date=="2007-02-02")
        png(filename="plot4.png",width = 480,height = 480)
        myExData <- mutate(myExData,DateTime=paste(as.character(Date)," ",Time))
        # Plotting the Plot4
        #---------------------------------------
        par(mfcol = c(2,2))
        plot(x=as.POSIXct(myExData$DateTime),y=myExData$Global_active_power,ylab="Global Active Power",xlab="",type="l")
        plot(x=as.POSIXct(myExData$DateTime),y=myExData$Voltage,ylab="Voltage",xlab="datetime",type="l")

        plot(x=as.POSIXct(myExData$DateTime),xlab="",y=myExData$Sub_metering_1,type="l",ylim=c(0,40),col=rgb(1,0,0),ylab="Energy Sub Metering")
        par(new=T)
        plot(x=as.POSIXct(myExData$DateTime),xlab="",y=myExData$Sub_metering_2,type="l",ylim=c(0,40),col=rgb(0,1,0),ylab="Energy Sub Metering")
        par(new=T)
        plot(x=as.POSIXct(myExData$DateTime),xlab="",y=myExData$Sub_metering_3,type="l",ylim=c(0,40),col=rgb(0,0,1),ylab="Energy Sub Metering")
        par(new=T)
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n", col=c(rgb(1,0,0),rgb(0,1,0),rgb(0,0,1)),horiz=F,lty = c(1,1,1))
        par(new=F)
        
        plot(x=as.POSIXct(myExData$DateTime),y=myExData$Global_reactive_power,ylab="Global Reactive Power",xlab="datetime",type="l",col=1)
        par(new=F)
        #---------------------------------------
        dev.off()
    }else
    {
        message("Installing dplyr package ... ")
        install.packages("dplyr")
        library("dplyr")
    }
}else
{
    stop("The data file household_power_consumption.txt was not found in the current directory")
}