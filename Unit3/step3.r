## Step 3 - Replications with Flexible Layout and Dynamic Image Size

# Here set number of rows and columns
rows <- 4
cols <- 8

# Setting the desired size for each individual plot
width_per_plot <- 800   # in pixels
height_per_plot <- 800  # in pixels

# Calculate total image width and height
total_width <- cols * width_per_plot
total_height <- rows * height_per_plot

# Save the picture as a PNG file
png(paste0("Step3_", rows, "_", cols, "samples.png"), width=total_width, height=total_height, res=200)

# Parameters
n <- 30
mu <- 180
sd <- 20
sdd <- 3.5
bin.width <- sd / 3
x.min <- mu - (sdd * sd)
x.max <- mu + (sdd * sd)
y.max <- n * 0.5 * bin.width / sd
x <- seq(x.min, x.max, length=120)

# Seting up the graphic layout
par(mfrow=c(rows, cols))

# For loop to generate samples
for (i in 1:(rows * cols)) {
  
  v <- rnorm(n, mu, sd)
  
  hist(v, xlim=c(x.min, x.max), ylim=c(0, y.max),
       breaks = seq(mu-5*sd, mu+5*sd, by=bin.width),
       main=paste("Sample", i),
       xlab="Value", col="lightgray", border="white")
  
  # True normal distribution (blue solid line)
  points(x, dnorm(x, mu, sd)*(n*bin.width), type="l", col="blue", lty=1, lwd=2)
  
  # Estimated normal distribution (red dashed line)
  points(x, dnorm(x, mean(v), sd(v))*(n*bin.width), type="l", col="red", lty=2, lwd=2)
  
  # Adding sample mean, sample standard deviation, and Pr(t)
  text(x.min, 0.9*y.max, paste("mean:", round(mean(v),2)), pos=4)
  text(x.min, 0.8*y.max, paste("sdev:", round(sd(v),2)), pos=4)
  text(x.min, 0.7*y.max, paste("Pr(t):", round((t.test(v, mu=mu))$p.value, 4)), pos=4)
}

# Cleaning up
par(mfrow=c(1,1))
dev.off()
