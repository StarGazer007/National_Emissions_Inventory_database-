## Course: Exploratory Data Analysis 
## Assignment: Course Project 2
## Lisa Rodgers
## 04/29/2016
## 
## Question 5:
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

#clear the workspace
rm(list = ls())

# Read PM2.5 emissions dataset
NEI <- readRDS('summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('Source_Classification_Code.rds')


# Get the emissions from motor vehicle sources (type = ON-ROAD) in Baltimore City (fips code: '24510')
baltimore.motor.emissions <- NEI[NEI$type == 'ON-ROAD' & NEI$fips == '24510', ]

# Get the total Baltimore emissions from motor vehicle sources by year
baltimore.motor.emissions.by.year <- aggregate(Emissions ~ year, data = baltimore.motor.emissions, FUN = sum)


# Open png device
png(filename='plot5.png', width=480, height=480, units='px')

# Print numeric values in fixed notation
options(scipen=10)

with(baltimore.motor.emissions.by.year, {
  plot(year, Emissions, type = 'b',
       xlab="Year",
       ylab='PM2.5 Emissions (tons)',
       main='PM2.5 Emissions from motor vehicle sources in Baltimore City')
})

# Close png device
dev.off()