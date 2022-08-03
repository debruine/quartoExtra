#' Set up dark mode in quarto
#'
#' See https://quarto.org/docs/output-formats/html-themes.html for more info about themes and setting up dark mode
#'
#' @param light_theme the light bootswatch theme
#' @param dark_theme the dark bootswatch theme
#' @param quarto_yml the location of the _quarto.yml file
#' @param light_scss the location of the custom scss file for the light theme
#' @param dark_scss the location of the custom scss file for the dark theme
#' @param default whether the light or dark theme is the default
#' @param type the type of quarto document ("website" or "book")
#'
#' @return NULL
#' @export
#'
darkmode_setup <- function(light_theme = "flatly",
                           dark_theme = "darkly",
                           quarto_yml = "_quarto.yml",
                           light_scss = "light.scss",
                           dark_scss = "dark.scss",
                           default = "light",
                           type = c("website", "book")) {
  type = match.arg(type)

  # create or update yml
  if (!file.exists(quarto_yml)) {
    template_yml <- list(
      project = list(
        type = type,
        "output-dir" = "docs"
      ),
      type = list(
        title = "TITLE"
      ),
      format = list(
        html = list(
          theme = list()
        )
      )
    )
    names(template_yml)[2] <- type

    if (default == "light") {
      template_yml$format$html$theme$light <- c(light_theme, light_scss)
      template_yml$format$html$theme$dark <- c(dark_theme, dark_scss)
    } else {
      template_yml$format$html$theme$dark <- c(dark_theme, dark_scss)
      template_yml$format$html$theme$light <- c(light_theme, light_scss)
    }

    yaml::write_yaml(template_yml, quarto_yml)
    message("Setup created at ", quarto_yml)
  } else {
    orig_yml <- yaml::read_yaml(quarto_yml)

    if (!is.list(orig_yml$format) &&
        orig_yml$format == "html") {
      orig_yml$format <- list(html = list())
    }
    if (!is.list(orig_yml$format$html$theme)) {
      orig_yml$format$html$theme <-list()
    }

    if (default == "light") {
      orig_yml$format$html$theme$light <- c(light_theme, light_scss)
      orig_yml$format$html$theme$dark <- c(dark_theme, dark_scss)
    } else {
      orig_yml$format$html$theme$dark <- c(dark_theme, dark_scss)
      orig_yml$format$html$theme$light <- c(light_theme, light_scss)
    }

    yaml::write_yaml(orig_yml, quarto_yml)
    message("Setup updated at ", quarto_yml)
  }

  ## create or update dark theme ----
  dark_template <- system.file("dark.scss", package = "quartoExtra")
  dark_text <-  readLines(dark_template, warn = FALSE)

  if (!file.exists(dark_scss)) {
    write(dark_text, dark_scss)
    message("Dark theme created at ", dark_scss)
  } else {
    orig_scss <- readLines(dark_scss)
    rules_start <- grep("^/\\*-- scss\\:rules --\\*/", orig_scss)
    light_mode <- grep(".light-mode", orig_scss)
    dark_mode <- grep(".dark-mode", orig_scss)

    if (length(light_mode) | length(dark_mode)) {
      warning(".light-mode and/or .dark-mode are already defined in ",
      dark_scss)
    } else if (length(rules_start) == 0) {
      warning(dark_scss, " does not seem to be in SASS format")
    } else {
      new_scss <- c(
        orig_scss[1:rules_start],
        dark_text[4:length(dark_text)],
        orig_scss[(rules_start+1):length(orig_scss)]
      )
      write(paste(new_scss, collapse = "\n"), dark_scss)
      message("Dark theme updated at ", dark_scss)
    }
  }

  ## create or update light theme ----
  light_template <- system.file("light.scss", package = "quartoExtra")
  light_text <-  readLines(light_template, warn = FALSE)

  if (!file.exists(light_scss)) {
    write(light_text, light_scss)
    message("Light theme created at ", dark_scss)
  } else {
    orig_scss <- readLines(light_scss)
    rules_start <- grep("^/\\*-- scss\\:rules --\\*/", orig_scss)
    light_mode <- grep(".light-mode", orig_scss)
    dark_mode <- grep(".dark-mode", orig_scss)

    if (length(light_mode) | length(dark_mode)) {
      warning(".light-mode and/or .dark-mode are already defined in ",
              light_scss)
    } else if (length(rules_start) == 0) {
      warning(light_scss, " does not seem to be in SASS format")
    } else {
      new_scss <- c(
        orig_scss[1:rules_start],
        light_text[4:length(light_text)],
        orig_scss[(rules_start+1):length(orig_scss)]
      )
      write(paste(new_scss, collapse = "\n"), light_scss)
      message("Light theme updated at ", dark_scss)
    }
  }
}



#' Set the dark and light ggplot themes for darkmode
#'
#' @param dark the dark theme
#' @param light the light theme
#'
#' @return NULL
#' @export
#'
darkmode_theme_set <- function(dark = ggthemes::theme_solarized(light=FALSE),
                               light = ggthemes::theme_solarized(light=TRUE)) {
  assign("dark_theme", dark, envir=.pkgglobalenv)
  assign("light_theme", light, envir=.pkgglobalenv)

  invisible()
}
