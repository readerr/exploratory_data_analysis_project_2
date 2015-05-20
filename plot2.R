NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')

# add library dplyr for processing of the data
library(dplyr)

subset_Baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize( PM25 = sum(Emissions) ) 

png(filename = 'plot2.png', width = 550, height = 550)

barplot( subset_Baltimore$PM25,
         names.arg = subset_Baltimore$year,
         yaxt = 'n',
         ylab = 'Total PM25 Emissions',
         xlab = 'year',
         main = 'Total PM25 emissions in Baltimore City, Maryland '
         )

axis(2, at = pretty(seq(0, max(subset_Baltimore$PM25))),
     labels = format( pretty(seq(0, max(subset_Baltimore$PM25))),
                      big.mark = ',',
                      format = 'd')
     )

dev.off()