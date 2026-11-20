#' rglm: data generation for generalized linear models
#' @export
#' @aliases rglm
#' @param formula a formula containing the linear predictor.
#' @param beta vector of regression coefficients.
#' @param family a character string or a family object specifying the distribution of the response variable.
#' @param phi dispersion parameter.
#' @param data a data.frame containing the set of covariates entering the linear predictor.
#' @param offset optional numeric vector with an a priori known offset added to the linear predictor. If `NULL`, any `offset()` term in `formula` is used.
#' @param ... further arguments passed to other methods.
#' @return a numeric vector containing the generated response variable.
#'
rglm <- function (formula, beta, family, phi = NULL, data = NULL, offset = NULL, ...){
  call <- match.call()
  if(is.character(family)){
    family <- get(family, mode = "function", envir = parent.frame())
    family <- family()
  }
  mf <- match.call(expand.dots = FALSE)
  m <- match(c("formula", "data"), names(mf), 0L)
  mf <- mf[c(1L, m)]
  mf[[1L]] <- quote(stats::model.frame)
  mf <- eval(mf, parent.frame())
  mt <- attr(mf, "terms")
  X <- stats::model.matrix(mt, mf, ...)
  n <- nrow(X)
  p <- ncol(X)
  if (length(beta) != p) {
    warning("X and beta are incompatible")
  }

  eta <- as.numeric(X %*% beta)
  if (is.null(offset)) offset <- stats::model.offset(mf)
  if (!is.null(offset)) eta <- eta + offset
  mu <- family$linkinv(eta)
  y =  switch(
    family$family,
    "binomial" = stats::rbinom(n, prob = mu, ...),
    "poisson" = stats::rpois(n, mu),
    "bell" = bellreg::rbell(n, LambertW::W(mu)),
    "Gamma" = stats::rgamma(n, shape = 1/phi, scale = mu*phi),
    "inverse.gaussian" = statmod::rinvgauss(n, mean = mu, dispersion = phi)
  )
  attributes(y) <- list(call = call, model.matrix=X, beta = beta, phi = phi)
  return(y)
}




# lp <- function (formula, beta, data = NULL, ...){
#   call <- match.call()
#   if(is.character(family)){
#     family <- get(family, mode = "function", envir = parent.frame())
#     family <- family()
#   }
#   mf <- match.call(expand.dots = FALSE)
#   m <- match(c("formula", "data"), names(mf), 0L)
#   mf <- mf[c(1L, m)]
#   mf[[1L]] <- quote(stats::model.frame)
#   mf <- eval(mf, parent.frame())
#   mt <- attr(mf, "terms")
#   X <- stats::model.matrix(mt, mf, ...)
#   n <- nrow(X)
#   p <- ncol(X)
#   if (length(beta) != p) {
#     warning("X and beta are incompatible")
#   }
#
#   eta <- as.numeric(X %*% beta)
#   return(eta)
# }

