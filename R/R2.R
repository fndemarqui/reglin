
#' Adjusted Coefficient of determination (R2adj)
#' @aliases R2adj
#' @export
#' @param object  object of class lm, usually, a result of a call to lm.
#' @param ... other objects of class lm, usually, a result of a call to lm.
#' @return the coefficient of determination associated with the fitted model.
#'

R2adj <- function(object, ...){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  #objects <- objects[-2]

  J <- nargs()
  r2adj <- c()
  for(j in 1:J){
    r2adj[j] <- summary(objects[[j]])$adj.r.squared
  }
  if(J>1){
    R2adj <- data.frame(
      fit = argnames,
      R2adj = r2adj
    ) %>%
      dplyr::arrange(R2adj)
    return(R2adj)
  }else{
    return(r2adj)
  }

}

# R2adj <- function(model){
#   summary(model)$adj.r.squared
# }


#' Coefficient of determination (R2)
#' @aliases R2
#' @export
#' @param object  object of class lm, usually, a result of a call to lm.
#' @param ... other objects of class lm, usually, a result of a call to lm.
#' @return the coefficient of determination associated with the fitted model.
#'

# R2 <- function(model){
#   summary(model)$r.squared
# }


R2 <- function(object, ...){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  #objects <- objects[-2]

  J <- nargs()
  r2 <- c()
  for(j in 1:J){
    r2[j] <- summary(objects[[j]])$r.squared
  }
  if(J>1){
    R2 <- data.frame(
      fit = argnames,
      R2 = r2
    ) %>%
      dplyr::arrange(R2)
    return(R2)
  }else{
    return(r2)
  }

}








