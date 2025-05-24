
## visualize the variability of small random samples

# Sample size
n <- 1000
# parameters of the normal distribution
mu <- 180; sd <- 20
# set up graphic display
par(mfrow=c(1, 1))
# number of sd's for histogram display
sdd <- 3.5
# compute bin width from sd and the number of bars 
bin.width=sd/3
# scale x-axis
x.min <- mu-(sdd*sd); x.max <- mu+(sdd*sd)
# scale y-axis
y.max <- n*0.5*bin.width/sd
# compute and display the graph
v <- rnorm(n, mu, sd)
hist(v, xlim=c(x.min,x.max), ylim=c(0, y.max),
breaks = seq(mu-5*sd, mu+5*sd, by=bin.width),
main="", xlab=paste("Sample 1"));
x <- seq(x.min, x.max, length=120)
# true normal distribution
points(x,dnorm(x, mu, sd)*(n*bin.width),
type="l", col="blue", lty=1, lwd=1.8)
# distribution estimated from sample
points(x,dnorm(x, mean(v), sd(v))*(n*bin.width),
type="l", col="red", lty=2, lwd=1.8)
# print sample params and Pr(t)
text(x.min, 0.9*y.max, paste("mean:", round(mean(v),2)),pos=4)
text(x.min, 0.8*y.max, paste("sdev:", round(sd(v),2)),pos=4)
text(x.min, 0.7*y.max,
paste("Pr(t):", round((t.test(v, mu=mu))$p.value,2)),pos=4)
# clean up
par(mfrow=c(1,1))
rm(n, mu, sd, v, sdd, bin.width, x.min, x.max, y.max, x)