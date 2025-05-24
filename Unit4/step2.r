# Step 2 > Save PNG from file input
# Defineing a data model and populate manually

sound_data <- data.frame(
  Tone = numeric(10),
  Frequency = numeric(10),
  Harmony = numeric(10),
  Parity = numeric(10)
)

sound_data$Tone      <- c(1, 3, 6, 9, 8, 6, 7, 13, 3, 6)
sound_data$Frequency <- c(2, 5, 4, 5, 12, 11, 4, 15, 5, 4)
sound_data$Harmony   <- c(4, 6, 7, 8, 14, 4, 6, 10, 7, 9)
sound_data$Parity    <- c(3, 4, 2, 3, 5, 5, 3, 6, 6, 5)


# Saveing PNG from file input
png(filename="Graph_File_Step2.png", height=600, width=800, bg="white")

plot(sound_data$Tone, 
    type="o", 
    col="blue", 
    ylim=c(0,15), 
    xlab="Features (X1-X10)", 
    ylab="Amount (1-15)", 
    main="Learning Samples"
    )

# Adding lines for other data
lines(sound_data$Frequency, type="o", col="red")
lines(sound_data$Harmony, type="o", col="green")
lines(sound_data$Parity, type="o", col="purple")

legend("topright", 
    legend=c("Tone", "Frequency", "Harmony", "Parity"), 
    col=c("blue", "red", "green", "purple"), 
    lty=1, 
    pch=1
    )

# Closeing the PNG device
dev.off()
