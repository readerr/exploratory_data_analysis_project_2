NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')


library(dplyr)
library(ggplot2)
library(grid)
options(scipen=999)


# Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


# includes diesel and gasoline vehicles
subset_vehicles <- filter(SEC, grepl( 'Vehicles', SEC$EI, ignore.case = T))
summary(subset_vehicles$EI)

subset_NEI_vehicles <- NEI %>% filter(SCC %in% subset_vehicles$SCC) %>% filter( fips == "24510" | fips == "06037") %>% group_by(year, fips) %>% summarize(PM25 = sum(Emissions))
subset_NEI_vehicles <- mutate(subset_NEI_vehicles, city = ifelse( fips == '24510', 'Baltimore City, MD', 'Los Angeles County, CA') )
subset_NEI_vehicles

png( filename = 'plot6.png', width = 550, height = 550 )

plot <- ggplot( subset_NEI_vehicles, aes( as.factor(year), PM25) )
type <- geom_bar(stat = 'identity')
grid <- facet_grid(. ~ city)
# axis <- scale_y_continuous( labels = waiver(), limits = c(0, 400))
theme <- theme( plot.margin = unit(c(1,1,1,1), 'cm'), plot.title = element_text(lineheight = 1.1, face = 'bold', vjust=2), axis.text.x = element_text(angle = 45, hjust = 1) ) 
labels <- labs( x = 'year', y = 'PM25 Emissions Vehicles', title = 'PM25 Emissions from Vehicles,\nBaltimore City, MD vs Los Angeles County, CA ')

render <- plot + type + grid + theme + labels
render

dev.off()



