

rlm <- function(formula, data, beta, sigma){
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
