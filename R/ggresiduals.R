
#' ggplot version of plot diagnostics for an lm object
#' @aliases ggresiduals
#' @export
#' @param object an object of class lm with the fitted linear model.
#' @param type the desired type of plot; available options are:
#' \itemize{
#'   \item default: for default R residual plots
#'   \item crPlots: for component + residuals plots
#'   \item avPlots: for added variable plots
#'   \item covPlots: for covariates vs stdresidual plots
#' }
#' @param which only used for the default type of plot; a subset of the numbers 1:6, by default 1:4, referring to:
#' \enumerate{
#'   \item Residuals vs Fitted
#'   \item Normal Q-Q" plot
#'   \item Scale-Location
#'   \item Cook's distance
#'   \item Residuals vs Leverage
#'   \item Cook's dist vs Lev./(1-Lev.)
#' }
#' @param ... further arguments passed to other methods.
#' @author Fábio N. Demarqui

ggresiduals <- function(object, type = c("default", "crPlots", "avPlots", "covPlots"), which = 1:4, ...){
  type <- match.arg(type)
  switch(
    type,
    "default" = defaultPlots(object, which, ...),
    "avPlots" = avPlots(object, ...),
    "crPlots" = crPlots(object, ...),
    "covPlots" = covPlots(object, ...)
  )
}

defaultPlots <- function(object, which = 1:4){
  df <- fortify(object)
  df1 <- length(coef(object))
  df2 <- object$df.residual
  f <- qf(0.5, df1, df2)

  p <- df1
  n <- length(object$residuals)

  p1 <- ggplot(df, aes(.data$.fitted, .data$.stdresid)) +
    geom_point() +
    geom_hline(yintercept = 0) +
    geom_smooth(se = FALSE) +
    ggtitle("residuals vs fitted")

  # p2 <- ggplot(df) +
  #   stat_qq(aes(sample = .stdresid)) +
  #   qqplotr::stat_qq_band() +
  #   geom_abline(color = "blue") +
  #   ggtitle("Normal Q-Q")

  p2 <- ggplot(df, aes(sample = .data$.stdresid)) +
    qqplotr::stat_qq_band(alpha = 0.4) +
    qqplotr::stat_qq_line(color = "blue") +
    qqplotr::stat_qq_point() +
    ggtitle("Normal Q-Q")

  p3 <- ggplot(df, aes(.data$.fitted, sqrt(abs(.data$.stdresid)))) +
    geom_point() +
    geom_smooth(se = FALSE)  +
    ggtitle("scale-location")

  p4 <- ggplot(df, aes(.data$.hat, .data$.stdresid)) +
    geom_point() +
    geom_abline(intercept = c(-2, 2), slope = 0, color = "blue", linetype="dashed") +
    geom_vline(xintercept = 2*p/n, color = "blue", linetype="dashed") +
    geom_smooth(se = FALSE, size = 0.5) +
    ggtitle("residuals vs leverage")

  tb <- df %>%
    mutate(
      influent = .data$.cooksd > f
    )

  # p5 <- ggplot(df, aes(x = seq_along(.cooksd), y = .cooksd)) +
  #   geom_point() +
  #   geom_segment(aes(x = seq_along(.cooksd), y = 0, xend = seq_along(.cooksd), yend = .cooksd)) +
  #   ggtitle("Cook's distance") +
  #   labs(x="observations")

  p5<- ggplot(tb, aes(x = seq_along(.data$.cooksd), y = .data$.cooksd, color = .data$influent)) +
    geom_point() +
    scale_color_manual(values = c("FALSE" = "black", "TRUE" = "red")) +
    geom_segment(aes(x = seq_along(.data$.cooksd), y = 0, xend = seq_along(.data$.cooksd), yend = .data$.cooksd)) +
    ggtitle("Cook's distance") +
    labs(x="observations") +
    theme(legend.position="none")

  p6 <- ggplot(df, aes(.data$.hat/(1 - .data$.hat), .data$.cooksd)) +
    geom_vline(xintercept = 0, colour = NA) +
    geom_abline(slope = seq(0, 3, by = 0.5), colour = "white") +
    geom_smooth(se = FALSE) +
    geom_point() +
    ggtitle("Cook's distance vs leverage")

  p <- list(p1, p2, p3, p4, p5, p6)[which]
  q <- length(p)
  if(q==1){
    p
  }else{
    gridExtra::grid.arrange(grobs = p, ncol = 2)
  }
}



covPlots <- function(object){
  mf <- data.frame(
    stdresid = rstandard(object)
  ) %>%
    dplyr::bind_cols(
      model.frame(object)[, -1, drop = FALSE]
    )

  labels <- names(mf)
  p <- ncol(mf)-1
  plots <- list()
  for(j in 1:p){
    df <- data.frame(
      x = mf[,j+1],
      stdresid = mf$stdresid
    )
    plots[[j]] <- ggplot(df, aes(x = .data$x, y = .data$stdresid)) +
      geom_point() +
      geom_smooth(se = FALSE) +
      xlab(labels[j+1])
  }
  if(p==1){
    gridExtra::grid.arrange(grobs = plots)
  }else{
    gridExtra::grid.arrange(grobs = plots, ncol = 2)
  }

}



