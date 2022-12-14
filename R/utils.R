

#---------------------------------------------
#' Generic S3 method se
#' @export
#' @param object a fitted model object.
#' @param ... further arguments passed to or from other methods.
#' @return the standard errors associated with a set of parameter estimators for a given model.
#'

se <- function(object, ...) UseMethod("se")


#---------------------------------------------
#' Estimated standard errors for the regression coefficients
#'
#' @aliases se.lm
#' @export
#' @param object an object of the class lm
#' @param ... further arguments passed to or from other methods
#' @return  the standard errors associated with the regression coefficients.
#'
se.lm <- function(object, ...){
  sqrt(diag(vcov(object)))
}


press <- function(object){
  return(sum(rstandard(object, type="pred")^2))
}


hat_matrix <- function(object){
  X <- model.matrix(object)
  XtX <- crossprod(X)
  H <- X%*%solve(XtX)%*%t(X)
  return(H)
}



#---------------------------------------------
#' Scaling of variables
#'
#' @aliases pad
#' @export
#' @param x a vector containing the values to be scaled (normal and unity scales are available)
#' @param type type of scaling to be applied.
#' @return  a vector with the scaled variable
#'
pad <- function(x, type = c("normal", "unit")){
  type <- match.arg(type)
  u <- (x-mean(x))
  switch(type,
         "normal" = u/sd(x),
         "unit" = u/sqrt(sum(u^2)),
  )
}
