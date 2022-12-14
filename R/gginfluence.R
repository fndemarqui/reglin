


plot_leverage <- function(object){

  leverage <- data.frame(
    leverage = stats::hatvalues(object)
  )
  n <- length(object$residuals)
  p <- length(coef(object))
  upr <- 3*p/n

  ggplot(leverage, aes(x = seq_along(.data$leverage), y = .data$leverage)) +
    geom_point() +
    geom_abline(intercept = upr, slope = 0, color = "blue", linetype="dashed") +
    geom_segment(aes(x = seq_along(.data$leverage), y = 0, xend = seq_along(.data$leverage), yend = .data$leverage)) +
    ggtitle("Leverage") +
    labs(x="observations") +
    ylim(range(c(0, upr, leverage$leverage))) +
    theme(legend.position="none")
}


plot_cooksd <- function(object){

  cooksd <- data.frame(
    cooksd = stats::cooks.distance(object)
  )
  n <- length(object$residuals)
  p <- length(coef(object))
  f <- qf(0.5, p, n-p)

  ggplot(cooksd, aes(x = seq_along(.data$cooksd), y = .data$cooksd)) +
    geom_point() +
    geom_abline(intercept = f, slope = 0, color = "blue", linetype="dashed") +
    geom_segment(aes(x = seq_along(.data$cooksd), y = 0, xend = seq_along(.data$cooksd), yend = .data$cooksd)) +
    ggtitle("Cook's distance") +
    labs(x="observations") +
    ylim(range(c(0, f, cooksd$cooksd))) +
    theme(legend.position="none")
}

plot_covratio <- function(object){

  n <- length(object$residuals)
  p <- length(coef(object))

  covratio  <- data.frame(
    obs = 1:n,
    covratio = abs(1 - stats::covratio(object))
  )

  ggplot(covratio, aes(x = seq_along(.data$covratio), y = .data$covratio)) +
    geom_abline(intercept = 3*p/(n-p), slope = 0, color = "blue", linetype="dashed") +
    geom_point() +
    geom_segment(aes(x = seq_along(.data$covratio), y = 0, xend = seq_along(.data$covratio), yend = .data$covratio)) +
    ggtitle("COVRATIO") +
    labs(x="observations", y="|1-covratio|", ) +
    ylim(range(c(0, 3*p/(n-p), covratio$covratio))) +
    theme(legend.position="none")
}


plot_dffits <- function(object){

  n <- length(object$residuals)
  p <- length(coef(object))

  lwr <- - 3*sqrt(p/(n-p))
  upr <- + 3*sqrt(p/(n-p))

  dffits <- data.frame(
    dffits = stats::dffits(object)
  )

  ggplot(dffits, aes(x = seq_along(.data$dffits), y = .data$dffits)) +
    geom_point() +
    geom_abline(intercept = 0, slope = 0, color = "blue") +
    geom_abline(intercept = c(lwr, upr), slope = 0, color = "blue", linetype="dashed") +
    geom_segment(aes(x = seq_along(.data$dffits), y = 0, xend = seq_along(.data$dffits), yend = .data$dffits)) +
    ggtitle("DFfitS") +
    labs(x="observations") +
    ylim(range(lwr, upr, dffits$dffits)) +
    theme(legend.position="none")
}

plot_dfbetas <- function(object){

  n <- length(object$residuals)
  p <- length(coef(object))

  dfbetas  <- data.frame(
    obs = 1:n
  ) %>%
    bind_cols(
      dfbetas = as.data.frame(stats::dfbetas(object))
    ) %>%
    pivot_longer(
      cols = -obs,
      names_to = "coefficient",
      values_to = "value"
    )


  ggplot(dfbetas, aes(x = obs, y = .data$value)) +
    geom_abline(intercept = 0, slope = 0, color = "blue") +
    geom_abline(intercept = c(-1, 1), slope = 0, color = "blue", linetype="dashed") +
    geom_point() +
    geom_segment(aes(x = obs, y = 0, xend = obs, yend = .data$value)) +
    ggtitle("DFbetaS") +
    labs(x="observations", y="dfbetas") +
    ylim(range(-1, 1, dfbetas$value)) +
    theme(legend.position="none") +
    facet_wrap(~coefficient)
}



#' ggplot version of influence diagnostic plots for an lm object
#' @aliases gginfluence
#' @export
#' @param object an object of class lm with the fitted linear model.
#' @param measure the desired influence diagnostic measure; available options are:
#' \itemize{
#'   \item leverage
#'   \item dfbetas
#'   \item cooksd
#'   \item dffits
#'   \item covratio
#' }
#' @param ... further arguments passed to other methods.
#' @author Fábio N. Demarqui

gginfluence <- function(object, measure = c("leverage", "dfbetas", "cooksd", "dffits", "covratio"), ...){
  measure <- match.arg(measure)
  switch (measure,
    "leverage" = plot_leverage(object),
    "dfbetas" = plot_dfbetas(object),
    "cooksd" = plot_cooksd(object),
    "dffits" = plot_dffits(object),
    "covratio" = plot_covratio(object),
  )

}
