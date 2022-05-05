#' Extra Stuff for Quarto
#'
#' @name quartoExtra
#' @aliases quartoExtra-package
#' @import utils
#' @importFrom knitr asis_output knit_print
NULL

.onLoad <- function(...) {
  registerS3method("knit_print", "ggplot", knit_print.ggplot)
  registerS3method("knit_print", "data.frame", knit_print.data.frame)

  # set default options
  op <- options()
  op.qe <- list(
    quartoExtra.darkmode = FALSE,
    quartoExtra.df_print = "paged"
  )
  toset <- !(names(op.qe) %in% names(op))
  if(any(toset)) options(op.qe[toset])

  invisible()
}

.onAttach <- function(libname, pkgname) {
  # sm = paste(
  #   "\n************",
  #   "Welcome to quartoExtra",
  #   "Turn off dark mode toggling with options(quartoExtra.darkmode = FALSE)",
  #   "Set df_print to \"kable\" or \"paged\" with options(quartoExtra.df_print = \"kable\")",
  #   "************",
  #   sep = "\n"
  # )
  #
  # packageStartupMessage(sm)
}
