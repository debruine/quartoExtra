#' Chunk hook for darkmode
#'
#' @param x chunk output
#' @param options chunk options
#' @param ... stuff to pass to default chunk hook
#' @keywords internal
darkmode_hook <- function(x, options, ...) {
  regular_output <- chunk_hook(x, options, ...)
  is_dark_light <- "dark-light" %in% options$classes &
    !"dark-mode" %in% options$classes &
    !"light-mode" %in% options$classes

  cell_classes <- paste(
    paste0(".", c("cell", options$classes)),
    collapse = " "
  )

  if (is_dark_light) {
    split_output <- strsplit(regular_output, "\n")[[1]]
    # TODO: test that this is specific enough to only find plot chunks
    cod <- grep("\\.cell-output-display", split_output)
    img <- grep("^\\!\\[", split_output)
    img_cod <- cod[(cod %in% (img-1))]

    # relies on plots being every other dark/light
    dark <- img_cod[rep(c(T, F), length.out = length(img_cod))]
    light <- img_cod[rep(c(F, T), length.out = length(img_cod))]

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

    paste0("::: {", cell_classes, "}\n",
           paste(split_output, collapse = "\n"),
           "\n:::")
  } else {
    paste0("::: {", cell_classes, "}\n",
           regular_output,
           "\n:::")
  }
}
