
#' ANOVA table for linear models
#' @aliases tab_anova
#' @export
#' @param model an object of class lm or aov with the fitted linear model.
#' @return the ANOVA table decomposed into model and error sources of variation.
#'

tab_anova <- function(model){
  mf <- model.frame(model)
  y <- model.response(mf)
  X <- model.matrix(model)
  n <- nrow(X)
  p <- ncol(X)
  r <- residuals(model)
  gl_res <- model$df.residual
  if(names(coef(model))[1]=="(Intercept)"){
    gl_total <- n-1
    SQTotal <- sum((y-mean(y))^2)
  }else{
    gl_total <- n
    SQTotal <- sum(y^2)
  }
  gl_mod <- gl_total - gl_res


  SQRes <- sum(r^2)
  SQMod <- SQTotal - SQRes
  QMRes <- SQRes/gl_res
  QMMod <- SQMod/gl_mod
  f0 <- QMMod/QMRes
  pvalue <- pf(f0, df1 = gl_mod, df2=gl_res, lower.tail = FALSE)
  tb <- cbind(
    Df = as.integer(c(gl_mod, gl_res, gl_total)),
    `Sum Sq` = c(SQMod, SQRes, SQTotal),
    `Mean Sq` = c(QMMod, QMRes, NA),
    `F value` = c(f0, NA, NA),
    `Pr(>F)` = c(pvalue, NA, NA)
  )
  rownames(tb) <- c("Model", "Error", "Total")
  tb <- as.data.frame(tb)
  cat("Analysis of Variance Table", "\n")
  cat("\n")
  stats::printCoefmat(tb, P.value=TRUE, has.Pvalue=TRUE,
                      na.print = "", tst.ind = 2:4)
}











