# step 1 - Basic Scatterplot

data(iris)

# Define colors and shapes by species
colors <- c("blue", "red", "green")[as.numeric(iris$Species)]
shapes <- c(15, 16, 17)[as.numeric(iris$Species)]  # square, circle, triangle

# Plot settings: wide figure, axes from zero, equal aspect ratio
plot(iris$Petal.Length, iris$Petal.Width,
     col=colors,
     pch=shapes,
     xlim=c(0, max(iris$Petal.Length) + 0.5),
     ylim=c(0, max(iris$Petal.Width) + 0.5),
     asp=1,  # equal unit length for x and y
     xlab="Petal length (cm)",
     ylab="Petal width (cm)",
     main="Anderson Iris Data")

# Add legend
legend("topleft", 
       legend=c("Setosa", "Versicolor", "Virginica"),
       col=c("blue", "red", "green"),
       pch=c(15, 16, 17))

