#' Set up dark mode in quarto
#'
#' See https://quarto.org/docs/output-formats/html-themes.html for more info about themes and setting up dark mode
#'
#' @param light_theme the light bootswatch theme
#' @param dark_theme the dark bootswatch theme
#' @param quarto_yml the location of the _quarto.yml file
#' @param light_scss the location of the custom scss file for the light theme
#' @param dark_scss the location of the custom scss file for the dark theme
#' @param type the type of quarto document ("website" or "book")
#'
#' @return NULL
#' @export
#'
darkmode_setup <- function(
    light_theme = "flatly",
    dark_theme = "darkly",
    quarto_yml = "_quarto.yml",
    light_scss = "light.scss",
    dark_scss = "dark.scss",
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
          theme = list(
            light = c(light_theme, light_scss),
            dark = c(dark_theme, dark_scss)
          )
        )
      )
    )
    names(template_yml)[2] <- type

    yaml::write_yaml(template_yml, quarto_yml)
    message("Setup created at ", quarto_yml)
  } else {
    orig_yml <- yaml::read_yaml(quarto_yml)

    if (!is.list(orig_yml$format) &
        orig_yml$format == "html") {
      orig_yml$format <- list(html = list())
    }
    if (!is.list(orig_yml$format$html$theme)) {
      orig_yml$format$html$theme <-list()
    }

    orig_yml$format$html$theme$light <- c(light_theme, light_scss)
    orig_yml$format$html$theme$dark <- c(dark_theme, dark_scss)
    yaml::write_yaml(orig_yml, quarto_yml)
    message("Setup updated at ", quarto_yml)
  }

  # create or update dark theme
  if (!file.exists(dark_scss)) {
    dark_text <-  paste(sep = "\n",
      "/*-- scss:defaults --*/",
      "",
      "/*-- scss:rules --*/",
      ".light-mode { display: none; }",
      ".dark-mode { display: block; }",
      ""
    )

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
        ".light-mode { display: none; }",
        ".dark-mode { display: block; }",
        orig_scss[(rules_start+1):length(orig_scss)]
      ) %>% paste(collapse = "\n")
      write(new_scss, dark_scss)
      message("Dark theme updated at ", dark_scss)
    }
  }

  # create or update light theme
  if (!file.exists(light_scss)) {
    light_text <-  paste(sep = "\n",
                        "/*-- scss:defaults --*/",
                        "",
                        "/*-- scss:rules --*/",
                        ".light-mode { display: block; }",
                        ".dark-mode { display: none; }",
                        ""
    )

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
        ".light-mode { display: none; }",
        ".dark-mode { display: block; }",
        orig_scss[(rules_start+1):length(orig_scss)]
      ) %>% paste(collapse = "\n")
      write(new_scss, light_scss)
      message("Light theme updated at ", dark_scss)
    }
  }
}
