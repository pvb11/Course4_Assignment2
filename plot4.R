# Load the packages
library(ggplot2)
library(plyr)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create the plot
coalcombscc1 <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal"))
coalcombscc2 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
coalcomb <- union(coalcombscc1$SCC, coalcombscc2$SCC)
coalcomb2 <- subset(NEI, SCC %in% coalcomb)
coalcombpm25year <- ddply(coalcomb2, .(year, type), function(x) sum(x$Emissions))
colnames(coalcombpm25year)[3] <- "Emissions"
png("plot4.png")
qplot(year, Emissions, data=coalcombpm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "black", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion PM2.5 Emissions by Source, Type, Year")) + xlab("Year") + ylab(expression("PM2.5 Emissions (tons)"))
dev.off()
