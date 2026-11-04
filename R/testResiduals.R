
#' Residuals Tests for Linear Regression Models
#' @export
#' @aliases testResiduals
#' @param object an object of class lm with the fitted linear model.
#' @param ... further arguments passed to other methods.
#' @author Fábio N. Demarqui
#'

testResiduals <- function(object, ...){

  resid <- residuals(object)
  n <- length(resid)
  if(n> 5000){
    cat("Anderson-Darling normality test", "\n")
    ad <- nortest::ad.test(resid)
    df <- data.frame(
      A = as.numeric(ad$statistic),
      "p-value" = ad$p.value
    )
  }else{
    cat("\n")
    cat("Shapiro-Wilk normality test", "\n")
    sw <- stats::shapiro.test(resid)
    df <- data.frame(
      W = as.numeric(sw$statistic),
      "p-value" = sw$p.value
    )
  }

  rownames(df) <- ""
  stats::printCoefmat(df, P.values=TRUE, has.Pvalue = TRUE, na.print = "-")
  cat("------", "\n")
  cat("\n")

  # teste de homocedasticidade da variância:
  print(car::ncvTest(object))
  cat("------", "\n")
  cat("\n")

  cat("Durbin-Watson Test for Autocorrelated Errors", "\n")
  set.seed(1234567890)
  print(car::durbinWatsonTest(object))
  cat("------", "\n")
  cat("\n")

  cat("Bonferroni Outlier Test", "\n")
  print(car::outlierTest(object))
  cat("\n")

}


