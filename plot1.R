# Load date into a dataframe
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
# Transform first column to Date
initial$Date <- as.Date(initial$Date, format = "%d/%m/%Y")
# Filter based on date for the desired dates
initial <- initial [ initial$Date >= as.Date("2007-02-01") & initial$Date <= as.Date("2007-02-02"),]
# Exclude non-complete records
initial <- initial [ complete.cases(initial), ]
# Plot histogram, color red and appropriate main title and xaxis description
par(cex.lab = 0.75, cex.axis = 0.75, mfrow=c(1,1))
with(initial, hist(Global_active_power, col="red" , main ="Global Active Power", xlab = "Global Active Power (kilowatts)"))

# Save image as png file
dev.copy(png, file = "plot1.png")
# close connection
dev.off()
# end