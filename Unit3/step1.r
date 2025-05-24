## Step 1 - Visualization for different sample sizes

# Parameters of the normal distribution
mu <- 180
sd <- 20
sdd <- 3.5
bin.width <- sd / 3
x.min <- mu - (sdd * sd)
x.max <- mu + (sdd * sd)
y.max <- 10000 * 0.5 * bin.width / sd  # this y.max will be adjusted manually if needed for better plots
x <- seq(x.min, x.max, length=120)

# Function to plot for a given sample size
plot_sample <- function(n) {
  # set up graphic
  par(mfrow=c(1,1))
  
  v <- rnorm(n, mu, sd)
  hist(v, xlim=c(x.min, x.max), ylim=c(0, y.max),
       breaks = seq(mu-5*sd, mu+5*sd, by=bin.width),
       main=paste("Sample Size n =", n),
       xlab="Value", col="lightgray", border="white")
  
  # true normal distribution
  points(x, dnorm(x, mu, sd) * (n * bin.width),
         type="l", col="blue", lty=1, lwd=2)
  
  # estimated normal distribution from the sample
  points(x, dnorm(x, mean(v), sd(v)) * (n * bin.width),
         type="l", col="red", lty=2, lwd=2)
  
  # print sample parameters and Pr(t)
  text(x.min, 0.9 * y.max, paste("mean:", round(mean(v),2)), pos=4)
  text(x.min, 0.8 * y.max, paste("sdev:", round(sd(v),2)), pos=4)
  text(x.min, 0.7 * y.max,
       paste("Pr(t):", round((t.test(v, mu=mu))$p.value, 4)), pos=4)
}

# Plot for different sample sizes
plot_sample(10)
#plot_sample(100)
#plot_sample(10000)

# Clean up
par(mfrow=c(1,1))
