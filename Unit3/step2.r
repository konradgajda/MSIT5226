# Save to a PNG file
png("Step2_3samples.png", width=2400, height=800, res=200)

# Plotting inside PNG
par(mfrow=c(1,3))  # 1 row x 3 columns
for (i in 1:3) {
  
  v <- rnorm(n, mu, sd)
  
  hist(v, xlim=c(x.min, x.max), ylim=c(0, y.max),
       breaks=seq(mu-5*sd, mu+5*sd, by=bin.width),
       main=paste("Sample", i),
       xlab="Value", col="lightgray", border="white")
  
  # True normal distribution (blue solid line)
  points(x, dnorm(x, mu, sd)*(n*bin.width), type="l", col="blue", lty=1, lwd=2)
  
  # Estimated distribution (red dashed line)
  points(x, dnorm(x, mean(v), sd(v))*(n*bin.width), type="l", col="red", lty=2, lwd=2)
  
  # Add text
  text(x.min, 0.9*y.max, paste("mean:", round(mean(v),2)), pos=4)
  text(x.min, 0.8*y.max, paste("sdev:", round(sd(v),2)), pos=4)
  text(x.min, 0.7*y.max, paste("Pr(t):", round((t.test(v, mu=mu))$p.value,4)), pos=4)
}

# Finish PNG
dev.off()
