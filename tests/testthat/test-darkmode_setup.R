test_that("setup", {
  tmp <- tempdir()
  yml <- file.path(tmp, "_quarto.yml")
  light <- file.path(tmp, "light.scss")
  dark <- file.path(tmp, "dark.scss")

  expect_message({
    darkmode_setup(light_theme = "cosmo",
                   dark_theme = "slate",
                   quarto_yml = yml,
                   light_scss = light,
                   dark_scss = dark,
                   type = "book")
  })

  ycheck <- yaml::read_yaml(yml)
  lcheck <- readLines(light)
  dcheck <- readLines(dark)

  expect_equal(ycheck$format$html$theme$light,
               c("cosmo", light))
  expect_equal(ycheck$format$html$theme$dark,
               c("slate", dark))
  expect_equal(names(ycheck)[[2]], "book")
  expect_equal(ycheck$project$type, "book")

  # update existing
  expect_warning({
    darkmode_setup(light_theme = "flatly",
                   dark_theme = "darkly",
                   quarto_yml = yml,
                   light_scss = light,
                   dark_scss = dark)
  })

  ycheck <- yaml::read_yaml(yml)
  expect_equal(ycheck$format$html$theme$light,
               c("flatly", light))
  expect_equal(ycheck$format$html$theme$dark,
               c("darkly", dark))


  unlink(yml)
  unlink(dark)
  unlink(light)
})
