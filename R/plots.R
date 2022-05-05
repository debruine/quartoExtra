#' Print ggplots in light/dark mode
#'
#' @param x an object with class ggplot
#' @param options chunk options
#' @param ... additional arguments to be passed onto print()
#'
#' @return html for light and dark mode plots
#' @export
#'
knit_print.ggplot <- function (x, options, ...) {
  darkmode <- "dark-mode" %in% options$classes |
    ("dark-light" %in% options$classes &
    !"light-mode" %in% options$classes)
  lightmode <- "light-mode" %in% options$classes |
    ("dark-light" %in% options$classes &
    !"dark-mode" %in% options$classes)

  # just print if neither darkmode nor lightmode are set
  if (!darkmode & !lightmode) {
    print(x)
    return()
  }

  # get themes
  dark_theme <- get("dark_theme", envir = .pkgglobalenv)
  light_theme <- get("light_theme", envir = .pkgglobalenv)

  # restore main theme on exit
  orig_theme <- ggplot2::theme_get()
  on.exit(ggplot2::theme_set(orig_theme))

  # dark mode
  if (darkmode) {
    ggplot2::theme_set(dark_theme)
    print(x)
  }

  # light mode
  if (lightmode) {
    ggplot2::theme_set(light_theme)
    print(x)
  }
}


#' Chunk hook for darkmode
#'
#' @param x chunk output
#' @param options chunk options
#' @keywords internal
darkmode_hook <- function(x, options) {
  regular_output <- x

  if ("dark-light" %in% options$classes) {
    split_output <- strsplit(regular_output, "\n")[[1]]
    # TODO: test that this is specific enough to only find plot chunks
    cod <- grep("\\.cell-output-display", split_output)

    # relies on plots being every other dark/light
    dark <- cod[rep(c(T, F), length.out = length(cod))]
    light <- cod[rep(c(F, T), length.out = length(cod))]

    split_output[dark] <- gsub(
      pattern = ".cell-output-display",
      replacement = ".cell-output-display .dark-mode",
      x = split_output[dark],
      fixed = TRUE
    )

    split_output[light] <- gsub(
      pattern = ".cell-output-display",
      replacement = ".cell-output-display .light-mode",
      x = split_output[light],
      fixed = TRUE
    )

    paste(split_output, collapse = "\n")
  } else if ("dark-mode" %in% options$classes) {
    gsub(
      pattern = ".cell-output-display",
      replacement = ".cell-output-display .dark-mode",
      x = regular_output,
      fixed = TRUE
    )
  } else if ("light-mode" %in% options$classes) {
    gsub(
      pattern = ".cell-output-display",
      replacement = ".cell-output-display .light-mode",
      x = regular_output,
      fixed = TRUE
    )
  } else {
    regular_output
  }
}
