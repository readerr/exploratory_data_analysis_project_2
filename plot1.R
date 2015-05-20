# read the data
NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')

# add library dplyr for processing of the data
# install.packages('dplyr')
library(dplyr)

# use dplyr to summarize the data by year
totalEmissions <- NEI %>% group_by(year) %>% summarize( PM25 = sum(Emissions) ) 

png(filename = 'plot1.png', width = 550, height = 550)

        # disable scientific notation
        # options(scipen=999)
        
        par(mar = c(5,5,5,5))

        barplot( totalEmissions$PM25,
                 names.arg = totalEmissions$year,
                 xlab = 'Year', 
                 ylab = 'Total PM25 emissions',
                 yaxt = "n",
                 cex.axis = 0.75, 
                 cex.lab = 0.75,
                 col.axis = 'black',
                 col = 'gray',
                 main = "Total PM25 Emissions 1999-2008, \n United States"
                 )
        
        
        axis(2, 
             at = pretty(seq( 0, max(totalEmissions$PM25) ) ), 
             labels = formatC(
                     pretty(seq( 0, max(totalEmissions$PM25) ) ),  
                     big.mark = ",", format = "d"
                     ), 
             col.axis = 'black',     
             las = 3)

dev.off()


