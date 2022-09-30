
#' ggplot version of plot diagnostics for an lm object
#' @aliases ggresiduals
#' @export
#' @param object an object of class lm with the fitted linear model.
#' @param which a subset of the numbers 1:6, by default 1:4, referring to:
#' \enumerate{
#'   \item "Residuals vs Fitted"
#'   \item "Normal Q-Q" plot
#'   \item "Scale-Location"
#'   \item "Cook's distance"
#'   \item "Residuals vs Leverage"
#'   \item "Cook's dist vs Lev./(1-Lev.)"
#' }
#'

ggresiduals <- function(object, which = 1:4){
  df <- fortify(object)

  p1 <- ggplot(df, aes(.fitted, .stdresid)) +
    geom_point() +
    geom_hline(yintercept = 0) +
    geom_smooth(se = FALSE) +
    ggtitle("residuals vs fitted")

  p2 <- ggplot(df) +
    stat_qq(aes(sample = .stdresid)) +
    geom_abline(color = "blue") +
    ggtitle("Normal Q-Q")

  p3 <- ggplot(df, aes(.fitted, sqrt(abs(.stdresid)))) +
    geom_point() +
    geom_smooth(se = FALSE)  +
    ggtitle("scale-location")

  p4 <- ggplot(df, aes(.hat, .stdresid)) +
    #geom_point(aes(size = .cooksd)) +
    # geom_vline(size = 2, colour = "white", xintercept = 0) +
    # geom_hline(size = 2, colour = "white", yintercept = 0) +
    geom_point() +
    geom_smooth(se = FALSE, size = 0.5) +
    ggtitle("residuals vs leverage")

  p5 <- ggplot(df, aes(x = seq_along(.cooksd), y = .cooksd)) +
    geom_point() +
    geom_segment(aes(x = seq_along(.cooksd), y = 0, xend = seq_along(.cooksd), yend = .cooksd)) +
    ggtitle("Cook's distance") +
    labs(x="observations")

  p6 <- ggplot(df, aes(.hat, .cooksd)) +
    geom_vline(xintercept = 0, colour = NA) +
    geom_abline(slope = seq(0, 3, by = 0.5), colour = "white") +
    geom_smooth(se = FALSE) +
    geom_point()

  p <- list(p1, p2, p3, p4, p5, p6)[which]
  q <- length(p)
  if(q==1){
    p
  }else{
    gridExtra::grid.arrange(grobs = p, ncol = 2)
  }
}
