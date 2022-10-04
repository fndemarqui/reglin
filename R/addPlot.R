ggaddplot <- function(model){
  mf <- stats::model.frame(model)
  X <- stats::model.matrix(model)
  if(colnames(X)[1] == "(Intercept)"){
    X <- X[,-1, drop = FALSE]
  }
  y <- stats::model.response(data = mf)
  ylabel <- names(mf)[1]

  p <- ncol(X)
  labels <- colnames(X)
  plots <- list()

  for(j in 1:p){
    fit1 <- lm(X[,j] ~ X[,-j])
    fit2 <- lm(y ~ X[,-j])
    r <- data.frame(
      x = residuals(fit1),
      y = residuals(fit2)
    )
    plots[[j]] <- ggplot(r, aes(x = x, y = y)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE) +
      xlab(paste0(labels[j], " | others")) +
      ylab(paste0(ylabel, " | others"))
  }
  if(p>1){
    gridExtra::grid.arrange(grobs = plots, ncol=2)
  }else{
    gridExtra::grid.arrange(grobs = plots)
  }
}
