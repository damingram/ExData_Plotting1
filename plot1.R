
# read in just the data for the two days from file in working directory

text<-grep("^(1/2/2007|2/2/2007|Date)", readLines("household_power_consumption.txt"), value=TRUE)
tfexdap1 <- tempfile()
writeLines(text, tfexdap1)

# make data frame

DataF <- read.table(tfexdap1, header = TRUE, sep=";", na.strings="?")
unlink(tfexdap1)
 
# make histogram

hist(DataF$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     col = "red", cex.lab = 0.7, cex.axis = 0.7, mgp = c(2.5, 0.8, 0), cex.main = 0.8)

# save to PNG file

dev.copy(png, file = "plot1.png")
dev.off()

