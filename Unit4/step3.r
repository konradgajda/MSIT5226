# Step 3 > Reading the data from file
# Defineing a data model and populate manually

sound_data <- data.frame(
  Tone = numeric(10),
  Frequency = numeric(10),
  Harmony = numeric(10),
  Parity = numeric(10)
)

# Reading the data directly from file (best practice)
sound_data <- read.table("Data.txt", header=TRUE, sep="\t")

# Saveing the chart
png(filename="Graph_File_Step3.png", height=600, width=800, bg="white")

plot(sound_data$Tone, type="o", col="blue", ylim=c(0,15),
     xlab="Features (X1-X10)", ylab="Amount (1-15)",
     main="Learning Samples")

lines(sound_data$Frequency, type="o", col="red")
lines(sound_data$Harmony, type="o", col="green")
lines(sound_data$Parity, type="o", col="purple")

legend("topright",
       legend=c("Tone", "Frequency", "Harmony", "Parity"),
       col=c("blue", "red", "green", "purple"),
       lty=1, pch=1)

dev.off()