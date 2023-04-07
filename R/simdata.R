
#' rlm: generation of data with a linear regression structure
#' @export
#' @aliases rlm
#' @param formula a formula containing the linear predictor.
#' @param data a data.frame containing the set of covariates entering the linear predictor
#' @param beta vector of regression coefficients
#' @param sigma error standard deviation
#' @return a data.frame containing the generated data
#'
rlm <- function(formula, data, beta, sigma){
  if((length(sigma) != 1) & (length(sigma) != nrow(data))) stop("sigma must be numeric or of size n!")
  mf <- stats::model.frame(formula=formula, data=data)
  X <- stats::model.matrix(formula, data = mf)
  n <- nrow(X)
  p <- ncol(X)
  if(length(beta) !=p ){
    warning("X and beta are incompatible")
  }
  data$y = as.numeric(X%*%beta) + rnorm(n, 0, sigma)
  return(data)
}
