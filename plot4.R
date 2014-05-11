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

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0), cex.lab = 0.65, cex.axis = 0.65)

# add top left graph
with(initial, plot(date.time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# add top right graph
with(initial, plot(date.time, Voltage, type="l", xlab= "datetime", ylab = "Voltage"))

# add bottom left graph 
with(initial, plot(date.time , Sub_metering_1,type = "l", xlab = "", ylab = "Energy Sub Metering"))
lines(date.time, initial$Sub_metering_2, type = "l", col = "red")
lines(date.time, initial$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1            ", "Sub_metering_2", "Sub_metering_3"), bty = "n", pt.cex = 1, cex = 0.65)

# add bottom right graph
with(initial, plot(date.time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

# Copy image to png file
dev.copy(png, file = "plot4.png")
dev.off()


