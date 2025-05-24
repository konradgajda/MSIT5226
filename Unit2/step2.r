# Step 2:
# Take 1000 samples of size 20 from standard normal distribution
# Plot histogram of sample means with red center (-1.669 to 1.669) and blue tails

set.seed(123)  # Ensure reproducibility

# Generate matrix: 1000 samples, each of size 20 (stored row-wise)
X_matrix <- matrix(rnorm(1000 * 20), nrow = 1000, ncol = 20)

# Compute the mean of each row (each sample of size 20)
sample_means <- rowMeans(X_matrix)

# Create histogram data of sample means without plotting
hist_means <- hist(sample_means, breaks = 50, plot = FALSE)

# Color bins: red for -1.669 ≤ mean ≤ 1.669, blue otherwise
bar_colors <- ifelse(hist_means$mids < -1.669 | hist_means$mids > 1.669, "blue", "red")

# Plot histogram with custom colors
plot(hist_means,
     col = bar_colors,
     main = "Histogram of Sample Means (1000 Samples, Size = 20)",
     xlab = "Sample Mean",
     ylab = "Frequency",
     border = "black")

# Add vertical lines at Z = ±1.669
abline(v = 1.669, col = "black", lty = 2, lwd = 2)
abline(v = -1.669, col = "black", lty = 2, lwd = 2)

# Add labels to the vertical lines
text(1.669, max(hist_means$counts) * 0.9, "Z = 1.669", pos = 4, col = "black")
text(-1.669, max(hist_means$counts) * 0.9, "Z = -1.669", pos = 2, col = "black")
