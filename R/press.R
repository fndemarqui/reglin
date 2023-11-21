


# internal function used to compute press statistic (single model)
PRESS <- function(object){
  r <- residuals(object)
  h <- hatvalues(object)
  press <-  (r/(1-h))^2
  return(sum(press))
}


#' PRESS statistic
#'
#' @aliases press
#' @export
#' @description Function to compute PRESS statistic for one or more models.
#' @param object one or more objects of class lm.
#' @param ... further arguments passed to or from other methods.
#' @return the PRESS statistic when a single model is passed to the function; otherwise, a data.frame with the PRESS statistic values is returned.
#' @examples
#' \donttest{
#' library(reglin)
#' data(entregas)
#'
#' fit0 <- lm(tempo ~ 1, data = entregas)
#' fit1 <- lm(tempo ~ caixas, data = entregas)
#' fit2 <- lm(tempo ~ distancia, data = entregas)
#' fit3 <- lm(tempo ~ caixas + distancia, data = entregas)
#' fit4 <- lm(tempo ~ caixas*distancia, data = entregas)
#'
#' press(fit1)
#' press(fit1, fit2, fit3, fit4)
#' }

press <- function(object, ...){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  #objects <- objects[-2]

  J <- nargs()
  press <- c()
  for(j in 1:J){
    press[j] <- PRESS(objects[[j]])
  }
  if(J>1){
    press <- data.frame(
      fit = argnames,
      press = press
    ) %>%
      dplyr::arrange(press)
  }
  return(press)
}

