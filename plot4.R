NEI <- readRDS('summarySCC_PM25.rds')
SEC <- readRDS('Source_Classification_Code.rds')


library(dplyr)
library(ggplot2)
library(grid)
options(scipen=999)

# SUBSET the SEC data to find Comb Coal
# The way I read the question we seek all instances of  Comb - ... - Coal
subset_coal <- filter(SEC, grepl( 'Coal', SEC$EI))
subset_comb_coal <- filter(subset_coal, grepl( 'Comb', subset_coal$EI))

# match rows based on scc_codes
subset_NEI_coal <- NEI %>% filter(SCC %in% subset_comb_coal$SCC) %>% group_by(year, type)  %>% summarize( PM25 = sum(Emissions) ) 
subset_NEI_coal

sapply(subset_NEI_coal, class)

png( filename = 'plot4.png', width = 550, height = 550 )

plot <- ggplot(subset_NEI_coal, aes( as.factor(year), PM25, fill=type ))
geom <- geom_bar(stat = 'identity')
# grid <- facet_grid( .~type, scales = "fixed")
theme <- theme( plot.margin = unit(c(1,1,1,1), 'cm'), plot.title = element_text(lineheight = 1.3, face = 'bold', vjust=2), axis.text.x = element_text(angle = 45, hjust = 1) ) 
labels <- labs( x = 'year', y = 'PM25 Emissions from Comb Coal', title = 'Pm25 Emissions from Comb Coal by type, USA')

render <- plot + geom  + theme + labels
render

dev.off()

