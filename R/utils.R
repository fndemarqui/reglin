

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
#' Variable standardization
#'
#' @aliases standardization
#' @export
#' @description Implementation of the unit normal and unit length scaling methods to produce standardized regression coefficients.
#' @param x a vector containing the values to be scaled (unit normal scaling and unit length scales)
#' @param type type of scaling to be applied.
#' @return a vector with the standardized variable
#'
standardization <- function(x, type = c("normal", "length")){
  type <- match.arg(type)
  u <- (x-mean(x))
  switch(type,
         "normal" = u/sd(x),
         "length" = u/sqrt(sum(u^2)),
  )
}
