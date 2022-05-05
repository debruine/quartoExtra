#' Print tables in kable or paged formats
#'
#' @param x an object with class data.frame
#' @param options chunk options
#' @param ... additional arguments to be passed onto print()
#'
#' @return html for kable or paged tables
#' @keywords internal
#'
knit_print.data.frame <- function (x, options, ...) {
  df_print <- options("quartoExtra.df_print")[[1]]

  if (is.null(df_print)) {
    rmd_knit_print_df(x, options, ...)
  } else if (df_print == "paged") {
    x <- rmarkdown::paged_table(x, options)
    rmd_print_paged(x)
  } else if (df_print == "kable") {
    x <- knitr::kable(x)
    knitr::knit_print(x, options, ...)
  } else {
    rmd_knit_print_df(x, options, ...)
  }
}

