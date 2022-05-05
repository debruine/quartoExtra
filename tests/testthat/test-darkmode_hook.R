test_that("darkmode_hook", {
  orig <- "```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::"
  no <- "::: {.cell}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"
  darklight <- "::: {.cell .dark-light}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display .dark-mode}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display .light-mode}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"
  dark <- "::: {.cell .dark-mode}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"
  light <- "::: {.cell .light-mode}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-1.png){width=672}\n:::\n\n::: {.cell-output-display}\n![](test_files/figure-html/unnamed-chunk-2-2.png){width=672}\n:::\n:::"

  res_no <- darkmode_hook(orig, list())
  expect_equal(no, res_no)

  res_dl <- darkmode_hook(orig, list(classes = "dark-light"))
  expect_equal(darklight, res_dl)

  res_dark <- darkmode_hook(orig, list(classes = "dark-mode"))
  expect_equal(dark, res_dark)

  res_light <- darkmode_hook(orig, list(classes = "light-mode"))
  expect_equal(light, res_light)
})

test_that("non-image", {
  orig <- "```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\nSomething else\n:::\n\n::: {.cell-output-display}\nSomething else\n:::\n:::"

  no <- "::: {.cell}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\nSomething else\n:::\n\n::: {.cell-output-display}\nSomething else\n:::\n:::\n:::"

  dl <- "::: {.cell .dark-light}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\nSomething else\n:::\n\n::: {.cell-output-display}\nSomething else\n:::\n:::\n:::"

  dark <- "::: {.cell .dark-mode}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\nSomething else\n:::\n\n::: {.cell-output-display}\nSomething else\n:::\n:::\n:::"

  light <- "::: {.cell .light-mode}\n```{.r .cell-code}\nggplot2::ggplot()\n```\n\n::: {.cell-output-display}\nSomething else\n:::\n\n::: {.cell-output-display}\nSomething else\n:::\n:::\n:::"

  res_no <- darkmode_hook(orig, list())
  expect_equal(no, res_no)

  res_dl <- darkmode_hook(orig, list(classes = "dark-light"))
  expect_equal(dl, res_dl)

  res_dark <- darkmode_hook(orig, list(classes = "dark-mode"))
  expect_equal(dark, res_dark)

  res_light <- darkmode_hook(orig, list(classes = "light-mode"))
  expect_equal(light, res_light)
})
