if (!require("scatterplot3d")) {
  install.packages("scatterplot3d")  # install it if not already installed
  library(scatterplot3d)             # then load it
}

color_map <- c("blue", "gold", "black")[as.integer(iris$Species)]
s3d <- scatterplot3d(x = iris$Sepal.Length,
                    y = iris$Sepal.Width,
                    z = iris$Petal.Length,
                    color = color_map,
                    pch = pch_map,
                    type = "h",
                    main = "3D Scatter Plot with Colors and Vertical Bars",
                    xlab = "Sepal Length (cm)",
                    ylab = "Sepal Width (cm)",
                    zlab = "Petal Length (cm)")