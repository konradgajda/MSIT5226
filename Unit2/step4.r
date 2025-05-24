# Step 4:
# Generate 1000 samples (each of size 20) from exponential distribution (λ = 0.6)
# Use a matrix: 1000 rows, each row is a sample
# Plot histogram of sample means with red for > 1.669, blue for ≤ 1.669

set.seed(123)  # For reproducibility

# Create matrix of 1000 rows (samples), each with 20 exponential values
X_exp_matrix <- matrix(rexp(1000 * 20, rate = 0.6), nrow = 1000, ncol = 20)

# Compute row means
sample_means_exp <- rowMeans(X_exp_matrix)

# Create histogram data of sample means
hist_exp_means <- hist(sample_means_exp, breaks = 50, plot = FALSE)

# Color bars: blue for means ≤ 1.669, red for > 1.669
bar_colors_exp <- ifelse(hist_exp_means$mids <= 1.669, "blue", "red")

# Plot histogram with color-coded bars
plot(hist_exp_means,
     col = bar_colors_exp,
     main = "Step 4: Sample Means from Exponential (λ = 0.6, n = 20)",
     xlab = "Sample Mean",
     ylab = "Frequency",
     border = "black")

# Add vertical line at 1.669
abline(v = 1.669, col = "black", lty = 2, lwd = 2)
text(1.669, max(hist_exp_means$counts) * 0.9, "x = 1.669", pos = 4, col = "black")
