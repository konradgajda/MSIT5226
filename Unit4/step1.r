# Step 1
# Defineing a data model and populate manually

sound_data_manual <- data.frame(
  Tone = numeric(10),
  Frequency = numeric(10),
  Harmony = numeric(10),
  Parity = numeric(10)
)

sound_data_manual$Tone      <- c(1, 3, 6, 9, 8, 6, 7, 13, 3, 6)
sound_data_manual$Frequency <- c(2, 5, 4, 5, 12, 11, 4, 15, 5, 4)
sound_data_manual$Harmony   <- c(4, 6, 7, 8, 14, 4, 6, 10, 7, 9)
sound_data_manual$Parity    <- c(3, 4, 2, 3, 5, 5, 3, 6, 6, 5)


# Showing the graphical representation of the data
plot(
    sound_data_manual$Tone, 
    type="o", 
    col="blue", 
    ylim=c(0,15), 
    xlab="Features (X1-X10)", 
    ylab="Amount (1-15)", 
    main="Learning Samples"
    )
lines(sound_data_manual$Frequency, type="o", col="red")
lines(sound_data_manual$Harmony, type="o", col="green")
lines(sound_data_manual$Parity, type="o", col="purple")

# Adding a legend
legend(
    "topright", 
    legend=c("Tone", "Frequency", "Harmony", "Parity"),
    col=c("blue", "red", "green", "purple"),
    lty=1, 
    pch=1
    )


