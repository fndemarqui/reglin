
#' rlm: generation of data with a linear regression structure
#' @export
#' @aliases rlm
#' @param formula a formula containing the linear predictor.
#' @param beta vector of regression coefficients
#' @param sigma error standard deviation
#' @param data a data.frame containing the set of covariates entering the linear predictor
#' @return a numeric vector containing the generated response variable.
#'
rlm <- function(formula, beta, sigma, data=NULL){
  if(is.null(data)){
    mf <- stats::model.frame(formula=formula, data = data)
  }else{
    mf <- stats::model.frame(formula=formula)
  }

  if((length(sigma) != 1) & (length(sigma) != nrow(mf))) stop("sigma must be numeric or of size n!")
  X <- stats::model.matrix(formula, data = mf)
  n <- nrow(X)
  p <- ncol(X)
  if(length(beta) !=p ){
    warning("X and beta are incompatible")
  }
  y = as.numeric(X%*%beta) + rnorm(n, 0, sigma)
  return(y)
}
