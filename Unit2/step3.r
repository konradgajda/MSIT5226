# Step 3: Histogram of 1000 exponential values (λ = 0.6)
# Colors: blue for values <= 1.669, red for values > 1.669

#set.seed(123)  # For reproducibility

# Generate 1000 values from exponential distribution with lambda = 0.6
X_exp <- rexp(1000, rate = 0.6)

# Create histogram data without plotting
hist_exp <- hist(X_exp, breaks = 50, plot = FALSE)

# Define bar colors: blue if value <= 1.669, else red
bar_colors <- ifelse(hist_exp$mids <= 1.669, "blue", "red")

# Plot histogram with colored bars
plot(hist_exp,
     col = bar_colors,
     main = "Histogram of x (Exponential λ = 0.6)",
     xlab = "x",
     ylab = "Frequency",
     border = "black")

# Add vertical dashed line at x = 1.669
abline(v = 1.669, col = "black", lty = 2, lwd = 2)
text(1.669, max(hist_exp$counts) * 0.9, "x = 1.669", pos = 4, col = "black")
