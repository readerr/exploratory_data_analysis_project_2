install.packages('ggplot2')
library(ggplot2)

NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')

# add library dplyr for processing of the data
library(dplyr)

subset_Baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize( PM25 = sum(Emissions) ) 


plot <- ggplot(data=subset_Baltimore, aes(year, PM25), geom = 'bar' )
type <- geom_bar( stat="identity" ) 

grid <- facet_grid( . ~ type ) 

theme <-  theme( plot.title = element_text(lineheight = 1.3, face = 'bold'), axis.text.x = element_text(angle = 45, hjust = 1) ) 

labels <- labs( x = 'year',
      y = 'PM25 Emissions',
      title = 'Pm25 Emissions by type for Balitmore, MD'
        )

render <- plot + type + grid + theme + labels

render