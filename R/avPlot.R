
avPlots <- function(object){
  mf <- stats::model.frame(object)
  X <- stats::model.matrix(object)
  if(colnames(X)[1] == "(Intercept)"){
    X <- X[,-1, drop = FALSE]
  }
  y <- stats::model.response(data = mf)
  ylabel <- names(mf)[1]

  p <- ncol(X)
  labels <- colnames(X)
  plots <- list()

  for(j in 1:p){
    if(p==1){
      fit1 <- lm(X[,j] ~ 1)
      fit2 <- lm(y ~ 1)
    }else{
      fit1 <- lm(X[,j] ~ X[,-j])
      fit2 <- lm(y ~ X[,-j])
    }
    r <- data.frame(
      x = residuals(fit1),
      y = residuals(fit2)
    )
    plots[[j]] <- ggplot(r, aes(x = .data$x, y = .data$y)) +
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
