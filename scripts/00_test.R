#Purpose: confirm the project template workes end to end
library(tidyverse)
library(here)

set.seed(2026) # Seed set for randomness

df <- tibble(x = rnorm(100), y = 2 * x + rnorm(100))

p <- ggplot(df, aes(x, y)) + geom_point(alpha = 0.6) + theme_minimal()

ggsave(here("output", "figures", "test_plot.png"), p, width = 6, height = 4)
write.csv(df, here("data", "clean", "test_data.csv"))

# Publishing to GitHub
usethis::use_github()
