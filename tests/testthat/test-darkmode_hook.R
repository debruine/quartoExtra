test_that("darkmode_hook", {
  orig <- "::: {.cell .dark-light}\n\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"
  dark <- "::: {.cell .dark-light}\n\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display .dark-mode}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display .dark-mode}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"
  light <- "::: {.cell .dark-light}\n\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display .light-mode}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display .light-mode}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"

  res_no <- darkmode_hook(orig, list(classes = "no"))
  expect_equal(orig, res_no)

  res_dark <- darkmode_hook(orig, list(classes = "dark-mode"))
  expect_equal(dark, res_dark)

  res_light <- darkmode_hook(orig, list(classes = "light-mode"))
  expect_equal(light, res_light)
})
