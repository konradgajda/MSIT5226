X <- rnorm(1000)
hx <- hist(X, breaks=50, plot=FALSE)
plot(hx, col=ifelse(abs(hx$breaks) < 1.669, 4, 2))