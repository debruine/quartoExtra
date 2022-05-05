#' Print tables in kable or paged formats
#'
#' @param x an object with class data.frame
#' @param options chunk options
#' @param ... additional arguments to be passed onto print()
#'
#' @return html for kable or paged tables
#' @export
#'
knit_print.data.frame <- function (x, options, ...) {
  df_print <- options("quartoExtra.df_print")[[1]]

  if (is.null(df_print)) {
    rmarkdown:::knit_print.data.frame(x, options, ...)
  } else if (df_print == "paged") {
    rmarkdown::paged_table(x, options) |>
      rmarkdown:::print.paged_df()
  } else if (df_print == "kable") {
    knitr::kable(x) |>
      knitr::knit_print(options, ...)
  } else {
    rmarkdown:::knit_print.data.frame(x, options, ...)
  }
}

