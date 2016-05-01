## Course: Exploratory Data Analysis 
## Assignment: Course Project 2
## Lisa Rodgers
## 04/29/2016
## 
## Question 4:
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?


# Read PM2.5 emissions dataset
NEI <- readRDS('summarySCC_PM25.rds')

# Read emission source classification dataset
SCC <- readRDS('Source_Classification_Code.rds')


# Get the coal combustion-related sources
# Use the 'Short.Name' field to find the coal combustion-related sources
scc.coal <- SCC[grep('coal', SCC$Short.Name), ]

# Get the emissions from coal combustion-related sources
coal.emissions <- NEI[NEI $SCC %in% scc.coal$SCC, ]
# Get the total emissions from coal combustion-related sources by year
coal.emissions.by.year <- aggregate(Emissions ~ year, data = coal.emissions, FUN = sum)


# Open png device
png(filename='plot4.png', width=480, height=480, units='px')

# Print numeric values in fixed notation
options(scipen=10)

with(coal.emissions.by.year, {
  plot(year, Emissions, type = 'b',
       xlab="Year",
       ylab='PM2.5 Emissions (tons)',
       main='PM2.5 Emissions from coal combustion sources in U.S.A.')
})

# Close png device
dev.off()