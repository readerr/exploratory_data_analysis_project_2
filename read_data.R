# read the data
NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')


total_PM25 <- 0
years <- c(1999, 2002, 2005, 2008)

unique(NEI$Pollutant)
unique(NEI$year)

head(NEI)

# barplot( NEI$Emissions, NEI$year )