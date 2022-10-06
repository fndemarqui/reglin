

ggcrplot <- function(object){
  mf <- stats::object.frame(object)
  ylabel <- names(mf)[1]
  mf <- mf[, -1, drop = FALSE]
  X <- stats::object.matrix(object)
  coefs <- coef(object)
  if(colnames(X)[1] == "(Intercept)"){
    X <- X[,-1, drop = FALSE]
    coefs <- coefs[-1]
  }

  plots <- list()
  p <- ncol(X)
  r <- residuals(object)
  labels <- names(coefs)

  for(j in 1:p){
    df <- tibble(
      x = mf[,j],
      y = r + coefs[j]*x
    )
    plots[[j]] <- ggplot(df, aes(x = x, y = y)) +
      geom_point() +
      geom_abline(slope = coefs[j], color = "red") +
      geom_smooth(se = FALSE) +
      xlab(labels[j]) +
      ylab(paste0("Component + Residual (", ylabel, ")"))
  }

  if(p>1){
    gridExtra::grid.arrange(grobs = plots, ncol=2)
  }else{
    gridExtra::grid.arrange(grobs = plots)
  }

}

