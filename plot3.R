# Load the packages
library(ggplot2)
library(plyr)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create the plot
baltimore <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))
colnames(typePM25.year)[3] <- "Emissions"
png("plot3.png") 
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City PM2.5 Emmission by source, type, year")) + xlab("Year") + ylab(expression("PM2.5 Emissions (tons)"))
dev.off()
