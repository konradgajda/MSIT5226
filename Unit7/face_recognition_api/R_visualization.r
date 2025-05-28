library(plotly)
df <- read.csv("c:/repo/R_MSIT5226/Unit7/face_recognition_api/face_encodings_export.csv")

# Simulate minor variation for testing if needed
df[2, 2:129] <- df[1, 2:129] + rnorm(128, mean = 0, sd = 0.01)
df$name[2] <- "AnotherFace"

# PCA and 3D plot
pca <- prcomp(df[, -1], scale. = TRUE)
pca_df <- data.frame(pca$x[, 1:3])
pca_df$name <- df$name

plot_ly(pca_df,
        x = ~PC1, y = ~PC2, z = ~PC3,
        color = ~name, type = "scatter3d", mode = "markers")
# Save the plot as an HTML file
htmlwidgets::saveWidget(as_widget(plot_ly(pca_df,
        x = ~PC1, y = ~PC2, z = ~PC3,
        color = ~name, type = "scatter3d", mode = "markers")),
        "face_recognition_plot.html", selfcontained = TRUE)