## Course: Ex ploratory Data Analysis 
##(https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)
## Assignment: Course Project 2
## 
## Question 1:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission
## from all sources for each of the years 1999, 2002, 2005, and 2008.



#clear the workspace
rm(list = ls())


## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("data/Source_Classification_Code.rds")
}


# Get the total emissions by year
emission.totals.by.year <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

# Open png device
png(filename='plot1.png', width=480, height=480, units='px')

# Print numeric values in fixed notation
options(scipen=10)

with(emission.totals.by.year, {
  plot(year, Emissions, type = 'b',  
       xlab="Year",
       ylab='PM2.5 Emissions (tons)',
       main='Total PM2.5 Emissions in U.S.A.')
})

# Close png device
dev.off()
