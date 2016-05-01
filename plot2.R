## Course: Exploratory Data Analysis 
## Assignment: Course Project 2
## Lisa Rodgers
## 04/29/2016
## 
## Question 2:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.



#clear the workspace
rm(list = ls())


## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("data/Source_Classification_Code.rds")
}


# Get the emissions in Baltimore City
baltimore.emissions = NEI[NEI$fips == '24510', ]

# Get the total emissions in Baltimore City by year
baltimore.emission.totals.by.year <- aggregate(Emissions ~ year, data = baltimore.emissions, FUN = sum)


# Open png device
png(filename='plot2.png', width=480, height=480, units='px')

# Print numeric values in fixed notation
options(scipen=10)

with(baltimore.emission.totals.by.year, {
  plot(year, Emissions, type = 'b',
       xlab="Year",
       ylab='PM2.5 Emissions (tons)',
       main='Total PM2.5 Emissions in Baltimore City')
})

# Close png device
dev.off()