% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simdata.R
\name{rlm}
\alias{rlm}
\title{rlm: generation of data with a linear regression structure}
\usage{
rlm(formula, data, beta, sigma)
}
\arguments{
\item{formula}{a formula containing the linear predictor.}

\item{data}{a data.frame containing the set of covariates entering the linear predictor}

\item{beta}{vector of regression coefficients}

\item{sigma}{error standard deviation}
}
\value{
a data.frame containing the generated data
}
\description{
rlm: generation of data with a linear regression structure
}
