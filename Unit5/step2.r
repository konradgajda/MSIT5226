if (!require("scatterplot3d")) {
  install.packages("scatterplot3d")  # install it if not already installed
  library(scatterplot3d)             # then load it
}

pch_map <- as.integer(iris$Species) + 15  # 16=circle, 17=triangle, 18=diamond # nolint
scatterplot3d(x = iris$Sepal.Length,
              y = iris$Sepal.Width,
              z = iris$Petal.Length,
              pch = pch_map,
              cex.symbols = 1.5,  # Increase this value for larger points
              main = "3D Scatter Plot with Species Shapes",
              xlab = "Sepal Length (cm)",
              ylab = "Sepal Width (cm)",
              zlab = "Petal Length (cm)")