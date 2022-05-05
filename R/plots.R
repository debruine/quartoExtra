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

