# Step 2 - Adding Mean, Median Lines and Centroids

data(iris)

# Define colors and shapes by species
colors <- c("blue", "red", "green")[as.numeric(iris$Species)]
shapes <- c(15, 16, 17)[as.numeric(iris$Species)]

# Blank plot to fully control axes and scaling
plot(iris$Petal.Length, iris$Petal.Width,
     col=colors,
     pch=shapes,
     xlim=c(0, 7),
     ylim=c(0, 2.5),
     asp=1,
     xlab="Petal length (cm)",
     ylab="Petal width (cm)",
     main="Anderson Iris Data",
     xaxt="n", yaxt="n")  # suppress default axes

# Custom axes
axis(1, at=seq(0, 7, by=1))               # X-axis: 0 to 7, step 1
axis(2, at=seq(0, 2.5, by=0.5), las=1)    # Y-axis: 0 to 2.5, step 0.5, horizontal labels

# Mean and median lines
abline(h=mean(iris$Petal.Width), col="red", lty=2)
abline(v=mean(iris$Petal.Length), col="red", lty=2)
abline(h=median(iris$Petal.Width), col="blue", lty=3)
abline(v=median(iris$Petal.Length), col="blue", lty=3)

# Centroids as diamonds with black border
points(mean(iris$Petal.Length), mean(iris$Petal.Width),
       pch=23, bg="red", col="black", cex=1.6)
points(median(iris$Petal.Length), median(iris$Petal.Width),
       pch=23, bg="blue", col="black", cex=1.6)

# Add legend
legend("topleft",
       legend=c("Setosa", "Versicolor", "Virginica"),
       col=c("blue", "red", "green"),
       pch=c(15, 16, 17))
