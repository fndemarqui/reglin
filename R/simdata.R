
#' rlm: generation of data with a linear regression structure
#' @export
#' @aliases rlm
#' @param formula a formula containing the linear predictor.
#' @param beta vector of regression coefficients
#' @param sigma error standard deviation
#' @param data a data.frame containing the set of covariates entering the linear predictor
#' @return a numeric vector containing the generated response variable.
#'
rlm <- function (formula, beta, sigma, data = NULL){
  mf <- match.call(expand.dots = FALSE)
  m <- match(c("formula", "data"), names(mf), 0L)
  mf <- mf[c(1L, m)]
  mf[[1L]] <- quote(stats::model.frame)
  mf <- eval(mf, parent.frame())
  mt <- attr(mf, "terms")

  if ((length(sigma) != 1) & (length(sigma) != nrow(mf)))
    stop("sigma must be numeric or of size n!")
  X <- stats::model.matrix(mt, mf)
  n <- nrow(X)
  p <- ncol(X)
  if (length(beta) != p) {
    warning("X and beta are incompatible")
  }
  y = as.numeric(X %*% beta) + rnorm(n, 0, sigma)
  return(y)
}
