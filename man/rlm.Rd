% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simdata.R
\name{rlm}
\alias{rlm}
\title{rlm: generation of data with a linear regression structure}
\usage{
rlm(formula, beta, sigma, data = NULL, ...)
}
\arguments{
\item{formula}{a formula containing the linear predictor.}

\item{beta}{vector of regression coefficients.}

\item{sigma}{error standard deviation.}

\item{data}{a data.frame containing the set of covariates entering the linear predictor.}

\item{...}{further arguments passed to other methods.}
}
\value{
a numeric vector containing the generated response variable.
}
\description{
rlm: generation of data with a linear regression structure
}
