NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')

# add library dplyr for processing of the data
library(dplyr)
library(ggplot2)

subset_Baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize( PM25 = sum(Emissions) ) 

png( filename = 'plot3.png', width = 550, height = 550 )
plot <- ggplot(data=subset_Baltimore, aes(as.factor(year), PM25, fill=type), geom = 'bar' )
type <- geom_bar( stat="identity" ) 

grid <- facet_grid( . ~ type ) 

theme <-  theme( plot.margin = unit(c(1,1,1,1), 'cm'), plot.title = element_text(lineheight = 1.3, face = 'bold', vjust = 2), axis.text.x = element_text(angle = 45, hjust = 1) ) 

labels <- labs( x = 'year',
      y = 'PM25 Emissions',
      title = 'Pm25 Emissions by type for Balitmore, MD'
        )

render <- plot + type + grid + theme + labels
render

dev.off()

