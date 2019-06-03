# Load the packages
library(ggplot2)
library(plyr)
library(grid)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create the plot
mvsource1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
mvsource2 <- SCC[SCC$EI.Sector %in% mvsource1, ]["SCC"]
emmvbalt <- NEI[NEI$SCC %in% mvsource2$SCC & NEI$fips == "24510", ]
emmvlosa <- NEI[NEI$SCC %in% mvsource2$SCC & NEI$fips == "06037", ]
emmvcomb <- rbind(emmvbalt, emmvlosa)
emmvcounty <- aggregate (Emissions ~ fips * year, data =emmvcomb, FUN = sum ) 
emmvcounty$county <- ifelse(emmvcounty$fips == "06037", "Los Angeles", "Baltimore")
png("plot6.png")
qplot(year, Emissions, data=emmvcounty, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emissions, 1999-2008, Los Angeles County and Baltimore")) + xlab("Year") + ylab(expression("PM2.5 Emissions"))
dev.off()
