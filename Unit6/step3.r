# Step 3 - Adding Regression Lines and Legend

library(MASS)  # for robust regression (lqs)

data(iris)

# Define colors and shapes by species
colors <- c("blue", "red", "green")[as.numeric(iris$Species)]
shapes <- c(15, 16, 17)[as.numeric(iris$Species)]

# Plot setup: fixed axes, equal scale, horizontal layout
plot(iris$Petal.Length, iris$Petal.Width,
     col=colors,
     pch=shapes,
     xlim=c(0, 7),
     ylim=c(0, 2.5),
     asp=1,
     xlab="Petal length (cm)",
     ylab="Petal width (cm)",
     main="Anderson Iris Data",
     xaxt="n", yaxt="n")

# Custom axis ticks
axis(1, at=seq(0, 7, by=1))
axis(2, at=seq(0, 2.5, by=0.5), las=1)

# Mean and median lines
abline(h=mean(iris$Petal.Width), col="red", lty=2)
abline(v=mean(iris$Petal.Length), col="red", lty=2)
abline(h=median(iris$Petal.Width), col="blue", lty=3)
abline(v=median(iris$Petal.Length), col="blue", lty=3)

# Centroids (as diamond shapes with black border)
points(mean(iris$Petal.Length), mean(iris$Petal.Width),
       pch=23, bg="red", col="black", cex=1.6)
points(median(iris$Petal.Length), median(iris$Petal.Width),
       pch=23, bg="blue", col="black", cex=1.6)

# Least-squares regression line
lm_model <- lm(Petal.Width ~ Petal.Length, data=iris)
abline(lm_model, col="red", lwd=2, lty=2)

# Robust regression line
lqs_model <- lqs(Petal.Width ~ Petal.Length, data=iris)
abline(lqs_model, col="blue", lwd=2, lty=4)

# First legend: Species with title
legend("topleft",
       inset=c(0, 0.02),
       title="Three species of Iris",
       legend=c("Setosa", "Versicolor", "Virginica"),
       col=c("blue", "red", "green"),
       pch=c(15, 16, 17),
       pt.cex=1.2,
       bty="n")

# Second legend: Centroid diamonds with title
legend("topright",
       inset=c(0, 0.08),
       legend=c("Mean", "Median"),
       title="Centroids: mean and median",
       pt.bg=c("red", "blue"),
       col="black",
       pch=23,
       pt.cex=1.6,
       bty="n")

# Regression line legend (placed slightly lower to avoid overlapping)
legend("bottomright",
       legend=c("Least Squares", "Robust Regression"),
       col=c("red", "blue"),
       lty=c(2, 4),
       lwd=2,
       bty="n")
