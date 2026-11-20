
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
#' @param alpha significance level used to determined inconsistent points in plot 5; default value is alpha = 0.05.
#' @param ... further arguments passed to other methods.
#' @author Fábio N. Demarqui

ggresiduals <- function(object, type = c("default", "crPlots", "avPlots", "covPlots"), which = 1:4, alpha = 0.05, ...){
  type <- match.arg(type)
  switch(
    type,
    "default" = defaultPlots(object, which, alpha, ...),
    "avPlots" = avPlots(object, ...),
    "crPlots" = crPlots(object, ...),
    "covPlots" = covPlots(object, ...)
  )
}

#' Default diagnostic plots for lm and glm objects
#'
#' Internal function called by [ggresiduals()] when `type = "default"`.
#'
#' @param object an object of class `lm` or `glm`.
#' @param which subset of `1:6` indicating which plots to draw:
#' residuals vs fitted, normal (or half-normal) Q-Q, predicted vs observed,
#' residuals vs leverage, Cook's distance, and Cook's distance vs leverage.
#' @param alpha significance level used to compute the cutoff for outlying
#' residuals in the residuals vs leverage plot.
#' @param type.residuals type of residuals: `"quantile"` (default), `"deviance"` or `"pearson"`
#' .
#' @param ... currently unused.
#' @return A list with a single ggplot object if `length(which) == 1`;
#' otherwise a grid of plots is drawn via [gridExtra::grid.arrange()].
#' @noRd
defaultPlots <- function(object, which = 1:4, alpha = alpha,
                         type.residuals = c("quantile", "deviance", "pearson"), ...){
  type.residuals <- match.arg(type.residuals)
  if(type.residuals == "quantile"){
    df <- broom::augment(object)
    df$.std.resid <-  qresid(object)
  }else{
    df <- broom::augment(object, type.residuals = type.residuals)
  }

  df1 <- length(coef(object))
  df2 <- object$df.residual
  f <- qf(0.5, df1, df2)

  p <- df1
  n <- length(object$residuals)

  p1 <- ggplot(df, aes(.data$.fitted, .data$.std.resid)) +
    geom_point() +
    geom_hline(yintercept = 0) +
    geom_smooth(se = FALSE) +
    ggtitle("residuals vs fitted")

  isGLM <- inherits(object, "glm")

  if(isGLM){
    set.seed(123)
    limits <- envelop(fit, ...)
    p2 <- ggplot(limits, aes(x = theoretical)) +
      geom_ribbon(
        aes(ymin = lower, ymax = upper),
        fill = "grey70",
        alpha = 0.7
      ) +
      geom_segment(
        data = data.frame(
          x = min(limits$theoretical),
          xend = max(limits$theoretical),
          y = min(limits$theoretical),
          yend = max(limits$theoretical)
        ),
        aes(x = x, y = y, xend = xend, yend = yend),
        color = "blue"
      ) +
      geom_point(aes(y = sample)) +
      ylab("sample")

      df$.pred <- stats::predict(object, type = "response")
      df$.obs <- if(is.null(object$y)){
        stats::model.response(stats::model.frame(object))
      }else{
        object$y
      }
      if(!is.numeric(object$y)){
        df$.obs <- as.numeric(df$.obs)
      }
      p3 <- ggplot(df, aes(.data$.pred, .data$.obs)) +
        geom_point() +
        geom_abline(slope = 1, intercept = 0, color = "blue")  +
        labs(x = "predicted", y = "observed") +
        ggtitle("predicted vs observed")

      cutoff <- stats::qnorm(alpha/(2*n), lower.tail=FALSE)
      bound <- 1.01*max(cutoff, abs(df$.std.resid))

      p4 <- ggplot(df, aes(.data$.hat, .data$.std.resid)) +
        geom_point() +
        geom_abline(intercept = c(-bound, bound), slope = 0, color = "blue", linetype="dashed") +
        geom_vline(xintercept = 3*p/n, color = "blue", linetype="dashed") +
        geom_smooth(se = FALSE, linewidth = 0.5) +
        ggtitle("residuals vs leverage") +
        ylim(min(df$.std.resid, -bound), max(df$.std.resid, bound))

      y_lab <- ifelse(type.residuals == "quantile", "quantile resid", paste("std. ", type.residuals, "resid"))
      p1 <- p1 + labs(y = y_lab)
      p4 <- p4 + labs(y = y_lab)

  }else{
    p2 <- ggplot(df, aes(sample = .data$.std.resid)) +
      qqplotr::stat_qq_band(alpha = 0.4) +
      qqplotr::stat_qq_line(color = "blue") +
      qqplotr::stat_qq_point() +
      ggtitle("Normal Q-Q")

    p3 <- ggplot(df, aes(.data$.fitted, sqrt(abs(.data$.std.resid)))) +
      geom_point() +
      geom_smooth(se = FALSE)  +
      ggtitle("scale-location")

    cutoff <- stats::qt(alpha/(2*n), df = df2-1, lower.tail=FALSE)
    bound <- 1.01*max(cutoff, abs(df$.std.resid))
    y_lab <- ifelse(type.residuals == "quantile", "quantile resid", paste("std. ", type.residuals, "resid"))

    p4 <- ggplot(df, aes(.data$.hat, .data$.std.resid)) +
      geom_point() +
      geom_abline(intercept = c(-cutoff, cutoff), slope = 0, color = "blue", linetype="dashed") +
      geom_vline(xintercept = 3*p/n, color = "blue", linetype="dashed") +
      geom_smooth(se = FALSE, linewidth = 0.5) +
      ggtitle("residuals vs leverage") +
      ylim(min(df$.std.resid, -bound), max(df$.std.resid, bound))
  }

  tb <- df %>%
    mutate(
      influent = .data$.cooksd > f
    )

  p5 <- ggplot(tb, aes(x = seq_along(.data$.cooksd), y = .data$.cooksd, color = .data$influent)) +
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
    p[[1]]
  }else{
    gridExtra::grid.arrange(grobs = p, ncol = 2)
  }
}


#' Covariates vs standardized residuals plots
#'
#' Plots the standardized residuals against each covariate of the model.
#' Also called by [ggresiduals()] when `type = "covPlots"`.
#'
#' @param object an object of class `lm` or `glm`.
#' @param type.residuals type of residuals used for `glm` objects:
#' `"deviance"`, `"pearson"` or `"quantile"`. Ignored for `lm` objects, for
#' which standardized residuals are used.
#' @param variable optional character string with the name of a single
#' covariate to plot; if `NULL` (default), all covariates are plotted.
#' @return Called for its side effect of drawing the plot(s).
#' @export
covPlots <- function(object, type.residuals = c("quantile", "deviance", "pearson"), variable = NULL){
  type.residuals <- match.arg(type.residuals)
  isGLM <- inherits(object, "glm")
  if(isGLM){
    residuals <- switch(type.residuals,
                        deviance = rstandard(object, type = "deviance"),
                        pearson = rstandard(object, type = "pearson"),
                        quantile = qresid(object)
    )
  }else{
    residuals <- rstandard(object)
  }

  if(isGLM){
    lab_resid <- paste0(type.residuals, " residuals")
  }else{
    lab_resid <- "std residuals"
  }

  mf <- eval(object$call$data)
  resp_vars <- all.vars(stats::formula(object)[[2]])
  mf <- mf %>%
    dplyr::select(-resp_vars)

  if(is.null(variable)){
    labels <- names(mf)
    p <- ncol(mf)
    plots <- list()
    for(j in 1:p){
      df <- data.frame(
        x = mf[,j],
        residuals = residuals
      )
      names(df) <- c("x", "residuals")
      plots[[j]] <- ggplot(df, aes(x = .data$x, y = .data$residuals)) +
        geom_point() +
        geom_smooth(se = FALSE) +
        xlab(labels[j]) +
        ylab(lab_resid)
    }
    if(p==1){
      gridExtra::grid.arrange(grobs = plots)
    }else{
      gridExtra::grid.arrange(grobs = plots, ncol = 2)
    }
  }else{
    if(!variable %in% names(mf)){
      stop("Variable not found in the model data.")
    }
    df <- data.frame(
      x = mf[[variable]],
      residuals = residuals
    )
    names(df) <- c("x", "residuals")
    p <- ggplot(df, aes(x = .data$x, y = .data$residuals)) +
      geom_point() +
      geom_smooth(se = FALSE) +
      xlab(variable) +
      ylab(lab_resid)
    print(p)
  }

}

