# Load the packages
library(ggplot2)
library(plyr)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create the plot
mvsource1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
mvsource2 <- SCC[SCC$EI.Sector %in% mvsource1, ]["SCC"]
emmvbalt <- NEI[NEI$SCC %in% mvsource2$SCC & NEI$fips == "24510",]
emmvbaltpm25yr <- ddply(emmvbalt, .(year), function(x) sum(x$Emissions))
colnames(emmvbaltpm25yr)[2] <- "Emissions"
png("plot5.png")
qplot(year, Emissions, data=emmvbaltpm25yr, geom="line") + ggtitle(expression("Baltimore City PM2.5 Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("PM2.5 Emissions (tons)"))
dev.off()
