test_that("knit_print.ggplot", {
  skip("Requires visual check")

  set.seed(8675309)
  x <- rnorm(1000)
  g <- ggplot2::ggplot() + ggplot2::geom_histogram(ggplot2::aes(x))
  knit_print.ggplot(g, list(classes = "dark-mode"))
  knit_print.ggplot(g, list(classes = "light-mode"))
  knit_print.ggplot(g, list(classes = "dark-light"))
})
