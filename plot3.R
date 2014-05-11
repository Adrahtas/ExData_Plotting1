# Load date into a dataframe
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
# Transform first column to Date
initial$Date <- as.Date(initial$Date, format = "%d/%m/%Y")
# Filter based on date for the desired dates
initial <- initial [ initial$Date >= as.Date("2007-02-01") & initial$Date <= as.Date("2007-02-02"),]
# Exclude non-complete records
initial <- initial [ complete.cases(initial), ]
# Retrieve date and time in one column
date.time <- strptime(paste(initial$Date,initial$Time), format = "%Y-%m-%d %H:%M:%S")
# Plot second graph using the "date.time" data along with the "Sub_metering_1" data.
par( cex.lab = 0.8, cex.main = 0.8, cex.axis = 0.8, mfrow = c(1,1))
with(initial, plot(date.time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
lines( date.time, initial$Sub_metering_2, type = "l", col = "red")
lines( date.time, initial$Sub_metering_3, type = "l", col = "blue")
legend("topright",lty = 1, pt.cex = 1, cex = 0.80, col = c("black","red","blue"), legend = c("Sub_metering_1            ", "Sub_metering_2", "Sub_metering_3"))

# Save image as png file
dev.copy(png, file = "plot3.png")
# close png connection
dev.off()
# end