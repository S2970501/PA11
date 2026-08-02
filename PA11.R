# COP2073C
# David Hulse
# 02AUG2026
# Using tidyverse, modelr and R to analyze data

# Install and load required packages
# Uncomment if install is required
# install.packages("tidyverse")
# install.packages("modelr")
library(tidyverse)
library(modelr)

# Create tibble using cyl and wt from mtcars
mt_tib <- mtcars %>%
  transmute(
    cyl = factor(cyl),
    wt
  )

# Fit linear model
model <- lm(wt ~ cyl, data = mt_tib)

# Create data grid/add predictions
grid <- mt_tib %>%
  data_grid(cyl) %>%
  add_predictions(model)

# Plot original data and predicted values
ggplot(mt_tib, aes(x = cyl, y = wt)) +
  geom_point() +
  geom_point(data = grid, aes(y = pred), color = "red", size = 4)

# Analysis:
# Looking at the model, the relationship between weight and cylinder count is
# pretty straightforward. Since cyl is categorical, the model is just
# estimating the average weight for each group rather than trying to fit a
# continuous trend. The red prediction points near the center of each cluster,
# which makes sense—they’re basically the mean weight for 4-, 6-, and
# 8‑cylinder cars. What stands out is how cleanly the pattern separates:
# as the number of cylinders goes up, so doesthe overall weight. There’s
# no overlap between the groups, so the model doesn’t have to do much to
# capture the trend. It’s a simple relationship, and the plot makes it easy to
# see how the model summarizes the data.