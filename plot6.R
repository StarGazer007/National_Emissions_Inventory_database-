## Course: Exploratory Data Analysis 
## Assignment: Course Project 2
## Lisa Rodgers
## 04/29/2016
## 
## Question 6:
## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

#clear the workspace
rm(list = ls())

library(ggplot2)

# Read PM2.5 emissions dataset
NEI <- readRDS('data/summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('data/Source_Classification_Code.rds')


# Get the emissions from motor vehicle sources (type = ON-ROAD) in Baltimore City (fips code: '24510') and Los Angeles (fips code: '06037')
city.NEI <- NEI[NEI$type == 'ON-ROAD' & NEI$fips %in% c('24510', '06037'), ]

# Get the total emissions for Baltimore City and Los Angeles, grouped by year and city
city.emissions.by.year <- aggregate(Emissions ~ year + fips, data = city.NEI, FUN = sum)

# Add city names for use in the plot
city.emissions.by.year$city = city.emissions.by.year$fips
city.emissions.by.year[which(city.emissions.by.year$fips == '24510'), 'city'] = 'Baltimore City'
city.emissions.by.year[which(city.emissions.by.year$fips == '06037'), 'city'] = 'Los Angeles'

# Open png device
png(filename='plot6.png', width=640, height=480, units='px')

# Print numeric values in fixed notation
options(scipen=10)

plot6 <- qplot(year, Emissions, data=city.emissions.by.year, facets = . ~ fips) +  
  geom_line() +
  xlab("Year") +
  ylab('PM2.5 Emissions (tons)') +
  ggtitle('Total PM2.5 Emissions in Los Angeles (06037) and Baltimore City (24510)')

print(plot6)

# Close png device
dev.off()