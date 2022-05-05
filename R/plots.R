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
  # just print if darkmode is off or not set
  if (!isTRUE(options("quartoExtra.darkmode")[[1]])) {
    print(x)
    return()
  }

  # TODO: user-customisable themes
  dark_theme <- ggthemes::theme_solarized(light = FALSE)
  light_theme <- ggthemes::theme_solarized(light = TRUE)

  # restore main theme on exit
  orig_theme <- ggplot2::theme_get()
  on.exit(ggplot2::theme_set(orig_theme))

  # dark mode
  if (!"light-mode" %in% options$classes) {
    cat('\n<div class="dark-mode">\n')
    ggplot2::theme_set(dark_theme)
    print(x)
    cat('</div>\n')
  }

  # light mode
  if (!"dark-mode" %in% options$classes) {
    cat('<div class="light-mode">\n')
    ggplot2::theme_set(light_theme)
    print(x)
    cat('</div>\n\n')
  }
}
