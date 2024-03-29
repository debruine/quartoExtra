% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setup.R
\name{darkmode_setup}
\alias{darkmode_setup}
\title{Set up dark mode in quarto}
\usage{
darkmode_setup(
  light_theme = "flatly",
  dark_theme = "darkly",
  quarto_yml = "_quarto.yml",
  light_scss = "light.scss",
  dark_scss = "dark.scss",
  default = "light",
  type = c("website", "book")
)
}
\arguments{
\item{light_theme}{the light bootswatch theme}

\item{dark_theme}{the dark bootswatch theme}

\item{quarto_yml}{the location of the _quarto.yml file}

\item{light_scss}{the location of the custom scss file for the light theme}

\item{dark_scss}{the location of the custom scss file for the dark theme}

\item{default}{whether the light or dark theme is the default}

\item{type}{the type of quarto document ("website" or "book")}
}
\description{
See https://quarto.org/docs/output-formats/html-themes.html for more info about themes and setting up dark mode
}
