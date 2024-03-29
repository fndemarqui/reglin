% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggresiduals.R
\name{ggresiduals}
\alias{ggresiduals}
\title{ggplot version of plot diagnostics for an lm object}
\usage{
ggresiduals(
  object,
  type = c("default", "crPlots", "avPlots", "covPlots"),
  which = 1:4,
  alpha = 0.05,
  ...
)
}
\arguments{
\item{object}{an object of class lm with the fitted linear model.}

\item{type}{the desired type of plot; available options are:
\itemize{
\item default: for default R residual plots
\item crPlots: for component + residuals plots
\item avPlots: for added variable plots
\item covPlots: for covariates vs stdresidual plots
}}

\item{which}{only used for the default type of plot; a subset of the numbers 1:6, by default 1:4, referring to:
\enumerate{
\item Residuals vs Fitted
\item Normal Q-Q" plot
\item Scale-Location
\item Cook's distance
\item Residuals vs Leverage
\item Cook's dist vs Lev./(1-Lev.)
}}

\item{alpha}{significance level used to determined inconsistent points in plot 5; default value is alpha = 0.05.}

\item{...}{further arguments passed to other methods.}
}
\description{
ggplot version of plot diagnostics for an lm object
}
\author{
Fábio N. Demarqui
}
