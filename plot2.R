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
        png(filename="plot2.png",width = 480,height = 480)
        myExData <- mutate(myExData,DateTime=paste(as.character(Date)," ",Time))
        # Plotting the Plot2
        plot(as.POSIXct(myExData$DateTime),myExData$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="Days",col=rainbow(1))
        message("plot2.png has been created with the graph")
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