NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')


library(dplyr)
library(ggplot2)
library(grid)
options(scipen=999)

# includes diesel and gasoline vehicles
subset_vehicles <- filter(SEC, grepl( 'Vehicles', SEC$EI, ignore.case = T))
summary(subset_vehicles$EI)

subset_NEI_vehicles <- NEI %>% filter(SCC %in% subset_vehicles$SCC) %>% filter( fips == "24510") %>% group_by(year) %>% summarize(PM25 = sum(Emissions))
subset_NEI_vehicles

png( filename = 'plot5.png', width = 550, height = 550 )

plot <- ggplot( subset_NEI_vehicles, aes( as.factor(year),  PM25) )
type <- geom_bar(stat = 'identity')
axis <- scale_y_continuous( labels = waiver(), limits = c(0, 400))
theme <- theme( plot.margin = unit(c(1,1,1,1), 'cm'), plot.title = element_text(lineheight = 1.3, face = 'bold', vjust=2), axis.text.x = element_text(angle = 45, hjust = 1) ) 
labels <- labs( x = 'year', y = 'PM25 Emissions Vehicles', title = 'PM25 Emissions from Vehicles, Baltimore City, MD')

render <- plot + axis+type + theme + labels
render

dev.off()


