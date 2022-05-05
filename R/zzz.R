#' Extra Stuff for Quarto
#'
#' @name quartoExtra
#' @aliases quartoExtra-package
#' @importFrom knitr asis_output knit_print
NULL

.pkgglobalenv <- new.env(parent=emptyenv())

rmd_knit_print_df <- utils::getFromNamespace("knit_print.data.frame", "rmarkdown")
rmd_print_paged <- utils::getFromNamespace("print.paged_df", "rmarkdown")

.onLoad <- function(...) {
  knitr::knit_hooks$set(chunk = darkmode_hook)

  # set default themes
  dark = ggthemes::theme_solarized(light=FALSE)
  light = ggthemes::theme_solarized(light=TRUE)
  assign("dark_theme", dark, envir=.pkgglobalenv)
  assign("light_theme", light, envir=.pkgglobalenv)

  registerS3method("knit_print", "ggplot", knit_print.ggplot)
  registerS3method("knit_print", "data.frame", knit_print.data.frame)

  # set default options
  op <- options()
  op.qe <- list(
    quartoExtra.df_print = NULL
  )
  toset <- !(names(op.qe) %in% names(op))
  if(any(toset)) options(op.qe[toset])

  invisible()
}

unregister_S3 = function() {
  if (!('knitr' %in% loadedNamespaces())) return()
  objs = ls(asNamespace('quartoExtra'))
  s3env = utils::getFromNamespace('.__S3MethodsTable__.', 'knitr')
  rm(list = intersect(objs, ls(s3env)), envir = s3env)
}

# remove S3 methods when the package is unloaded
.onUnload = function(libpath) unregister_S3()
