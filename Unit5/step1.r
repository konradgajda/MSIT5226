if (!require("scatterplot3d")) {
  install.packages("scatterplot3d")  # install it if not already installed
  library(scatterplot3d)             # then load it
}

scatterplot3d(x = iris$Sepal.Length,
              y = iris$Sepal.Width,
              z = iris$Petal.Length,
              cex.symbols = 1.5, # Increase this value for larger points
              main = "3D Scatter Plot",
              xlab = "Sepal Length (cm)",
              ylab = "Sepal Width (cm)",
              zlab = "Petal Length (cm)")