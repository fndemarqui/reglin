

crPlots <- function(object){
  mf <- stats::model.frame(object)
  ylabel <- names(mf)[1]
  mf <- mf[, -1, drop = FALSE]
  coefs <- coef(fit)
  plots <- list()
  p <- ncol(mf)
  r <- as.data.frame(residuals(object, "partial"))
  labels <- names(mf)

  for(j in 1:p){
    df <- tibble(
      x = mf[,j],
      y = r[,j]
    )
    if(is.factor(df$x)){
      plots[[j]] <- ggplot(df, aes(x = .data$x, y = .data$y)) +
        geom_boxplot() +
        ylab(paste0("Component + Residual (", ylabel, ")")) +
        xlab(labels[j])
    }else{
      beta <- coefs[labels[j]]
      names(beta) <- NULL
      plots[[j]] <- ggplot(df, aes(x = .data$x, y = .data$y)) +
        geom_point() +
        #geom_abline(slope = coefs[labels[j]], color = "red") +
        geom_abline(slope = beta, color = "red") +
        geom_smooth(se = FALSE) +
        xlab(labels[j]) +
        ylab(paste0("Component + Residual (", ylabel, ")"))
    }
  }

  if(p>1){
    gridExtra::grid.arrange(grobs = plots, ncol=2)
  }else{
    gridExtra::grid.arrange(grobs = plots)
  }

}

# crPlots <- function(object){
#   mf <- stats::model.frame(object)
#   ylabel <- names(mf)[1]
#   mf <- mf[, -1, drop = FALSE]
#   X <- stats::model.matrix(object)
#   coefs <- coef(object)
#   if(colnames(X)[1] == "(Intercept)"){
#     X <- X[,-1, drop = FALSE]
#     coefs <- coefs[-1]
#   }
#
#   plots <- list()
#   p <- ncol(X)
#   r <- residuals(object)
#   labels <- names(coefs)
#
#   for(j in 1:p){
#     df <- tibble(
#       x = mf[,j],
#       y = r + coefs[j]*.data$x
#     )
#     plots[[j]] <- ggplot(df, aes(x = .data$x, y = .data$y)) +
#       geom_point() +
#       geom_abline(slope = coefs[j], color = "red") +
#       geom_smooth(se = FALSE) +
#       xlab(labels[j]) +
#       ylab(paste0("Component + Residual (", ylabel, ")"))
#   }
#
#   if(p>1){
#     gridExtra::grid.arrange(grobs = plots, ncol=2)
#   }else{
#     gridExtra::grid.arrange(grobs = plots)
#   }
#
# }

