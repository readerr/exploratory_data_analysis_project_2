# read the data
NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')

# add library dplyr for processing of the data
# install.packages('dplyr')
library(dplyr)

unique(NEI$Pollutant)
unique(NEI$year)

head(NEI)

# use plyr to summarize the data by year
totalEmissions <- NEI %>% group_by(year) %>% summarize( PM25 = sum(Emissions) ) 

png(filename = 'plot1.png', width = 1550, height = 550)

        # disable scientific notation
        options(scipen=999)
        
        par(mar = c(5,5,5,5))

        barplot( totalEmissions$PM25,
                 names.arg = totalEmissions$year,
                 xlab = 'Year', 
                 ylab = 'Total PM25 emissions',
                 yaxt = "n",
                 cex.axis = 1.5, 
                 cex.lab = 1.25,
                 col.axis = 'slategray4',
                 col = 'tomato4',
                 main = "Total Emissions of PM25 per Year (All          
                 sources)"
                 )
        
        
        axis(2, 
             at = c(0, 1000*1000,pretty(totalEmissions$PM25)), 
             labels = formatC(
                     c(0, 1000*1000, pretty(totalEmissions$PM25)),  
                     big.mark = ",", format = "d"
                     ), 
             col.axis = 'slategray4',     
             las = 3)

dev.off()


