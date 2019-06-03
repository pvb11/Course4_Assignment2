# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create the plot
tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)
png("plot1.png")
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression("PM2.5 Emissions (tons)"), main = expression("US PM2.5 Emissions by Year"), col="Purple")
dev.off()
