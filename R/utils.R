

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
