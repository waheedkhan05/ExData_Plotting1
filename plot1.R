# Code for generating plot1.png
# I have used dplyr package for manipulation of data. I read the file complete first and then subset the data
# by using filter in dplyr. Only selecting the data of the required two days.

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
        png(filename="plot1.png",width = 480,height = 480)
        hist(myExData$Global_active_power,main = "Global Active Power",ylab="Frequency",xlab="Global Active Power (kilowatts)",col=rainbow(1))
        message("plot1.png has been created with the graph")
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

# Waheed Khan
# Copyrights 2015
# All rights Reserved
