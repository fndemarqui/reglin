
#' Adjusted Coefficient of determination (R2adj)
#' @aliases R2adj
#' @export
#' @param model an object of class lm or aov with the fitted linear model.
#' @return the coefficient of determination associated with the fitted model.
#'

R2adj <- function(model){
  summary(model)$adj.r.squared
}


#' Coefficient of determination (R2)
#' @aliases R2
#' @export
#' @param model an object of class lm or aov with the fitted linear model.
#' @return the coefficient of determination associated with the fitted model.
#'

R2 <- function(model){
  summary(model)$r.squared
}









