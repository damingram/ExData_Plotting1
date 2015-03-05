
# read in just the data for the two days from file in working directory

text<-grep("^(1/2/2007|2/2/2007|Date)", readLines("household_power_consumption.txt"), value=TRUE)
tfexdap1 <- tempfile()
writeLines(text, tfexdap1)

# make data frame

DataF <- read.table(tfexdap1, header = TRUE, sep=";", na.strings="?")
unlink(tfexdap1)

# create a datetime column

DataF$datetime <- strptime(paste(DataF$Date, DataF$Time), "%d/%m/%Y %H:%M:%S")

# make plot 4

par(mfrow = c(2, 2), mar = c(4, 4, 4, 1.5))

with(DataF, plot(datetime, Global_active_power, type = "l", xlab = "", mgp = c(2.5, 0.8, 0),
                 ylab = "Global Active Power", cex.lab = 0.7, cex.axis = 0.7)) 

with(DataF, plot(datetime, Voltage, type = "l", xlab = "datetime", mgp = c(2.5, 0.8, 0),
                 ylab = "Voltage", cex.lab = 0.7, cex.axis = 0.7)) 

with(DataF, plot(datetime, Sub_metering_1, type = "l", xlab = "",  mgp = c(2.5, 0.8, 0),
                 ylab = "Energy sub metering", cex.lab = 0.7, cex.axis = 0.7))
lines(DataF$datetime, DataF$Sub_metering_2, col = "red")
lines(DataF$datetime, DataF$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1",
                        "Sub_metering_2", "Sub_metering_3"), cex = 0.7, bty = "n")

with(DataF, plot(datetime, Global_reactive_power, type = "l", xlab = "datetime", mgp = c(2.5, 0.8, 0),
                 ylab = "Global_reactive_power", cex.lab = 0.7, cex.axis = 0.7)) 

# save to PNG file

dev.copy(png, file = "plot4.png")
dev.off()

