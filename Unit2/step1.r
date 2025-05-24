# Step 1: Histogram of 1000 random numbers from the standard normal distribution # nolint
# Breaks = 50, highlight Z = ±1.669 (middle in red, tails in blue)

set.seed(123)  # Ensureing reproducibility

# Generateing 1000 random values from standard normal distribution
X <- rnorm(1000)

# Createing histogram data without plotting
hist_data <- hist(X, breaks = 50, plot = FALSE)

# Assigning colors based on Z-score cutoff (±1.669)
bar_colors <- ifelse(hist_data$mids < -1.669 | hist_data$mids > 1.669, "blue", "red") # nolint

# Ploting histogram with assigned colors
plot(hist_data,
     col = bar_colors,
     main = "Histogram of x",
     xlab = "x",
     ylab = "Frequency",
     border = "black")

# Adding vertical dashed lines at Z = ±1.669
abline(v = 1.669, col = "black", lty = 2, lwd = 2)
abline(v = -1.669, col = "black", lty = 2, lwd = 2)

# Adding Z-score labels
text(1.669, max(hist_data$counts) * 0.9, "Z = 1.669", pos = 4, col = "black")
text(-1.669, max(hist_data$counts) * 0.9, "Z = -1.669", pos = 2, col = "black")
