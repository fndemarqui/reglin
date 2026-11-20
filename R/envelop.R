


# function adapted from stats::summary.glm()
dispersion <- function(object){
  phi <- object$family$dispersion
  df.r <- object$df.residual
  if(is.na(phi)){
    fam <- object$family
    phi <- if (df.r > 0){
      est.disp <- TRUE
      if (any(object$weights == 0))
        warning("observations with zero weight not used for calculating dispersion")
      sum((object$weights * object$residuals^2)[object$weights > 0])/df.r
    }
  }
  return(phi)
}


# glm_boot <- function(object){
#   beta <- stats::coef(object)
#   phi <- dispersion(object)
#   mf <- stats::model.frame(object)
#   resp_vars <- all.vars(stats::formula(object)[[2]])
#   Terms <- stats::terms(mf)
#
#   y <- mf[, 1, drop = FALSE]
#   X <- mf[, -1, drop = FALSE]
#   if(object$family$family == "binomial"){
#     names(y) <- "resp"
#     y <- as.data.frame(y$resp)
#     if(ncol(y) > 1){
#       m <- apply(y, 1, sum)
#       y[, 2] <- m
#     }else{
#       m <- rep(1, nrow(y))
#     }
#
#     names(y) <- resp_vars
#   }else{
#     m <- NULL
#   }
#
#
#   form <- stats::delete.response(Terms)
#   new <- rglm(form, beta = beta, phi = phi, family = object$family, data = X, size = m)
#   y[, 1] <- new
#   newdata <- dplyr::bind_cols(y, X)
#   fit <- update(object, data = newdata)
#   r <- sort(qresiduals(fit))
#   return(r)
# }

glm_boot <- function(object) {
  beta <- stats::coef(object)
  phi <- dispersion(object)
  mf <- stats::model.frame(object)
  off <- stats::model.offset(mf) # extrai o vetor de offset já avaliado (ex.: log(service))
  resp_vars <- all.vars(stats::formula(object)[[2]])
  Terms <- stats::terms(mf)

  y <- mf[, 1, drop = FALSE]
  # remove a coluna de offset de X se ela estiver presente no model.frame
  off_col <- attr(Terms, "offset")
  drop_cols <- if (!is.null(off_col)) c(1L, off_col) else 1L
  X <- mf[, -drop_cols, drop = FALSE]

  if (object$family$family == "binomial") {
    names(y) <- "resp"
    y <- as.data.frame(y$resp)
    if (ncol(y) > 1) {
      m <- apply(y, 1, sum)
    } else {
      m <- rep(1, nrow(y))
    }
    names(y) <- resp_vars
  } else {
    m <- NULL
  }

  form <- stats::delete.response(Terms)
  has_off <- !is.null(off)
  if (has_off) {
    # term.labels exclude offset terms, so the formula is rebuilt without them
    form <- stats::reformulate(
      attr(Terms, "term.labels"),
      intercept = attr(Terms, "intercept") == 1
    )
    X$.off_boot <- off
  }

  new <- rglm(form, beta = beta, phi = phi, family = object$family, data = X,
              offset = off, size = m)
  y[, 1] <- new
  # cbind(successes, failures): second column must be m - successes
  if (ncol(y) > 1) y[, 2] <- m - new
  newdata <- dplyr::bind_cols(y, X)

  if (has_off) {
    # offset is supplied via `offset=` so it also replaces any `offset=` argument in the original call
    fit_form <- stats::reformulate(
      attr(Terms, "term.labels"),
      response = stats::formula(object)[[2]],
      intercept = attr(Terms, "intercept") == 1
    )
    fit <- update(object, formula = fit_form, offset = .off_boot, data = newdata)
  } else {
    fit <- update(object, data = newdata)
  }

  r <- sort(qresiduals(fit))
  return(r)
}



envelop <- function(object, B = 1000, conf.level = 0.95, type.residuals = c("quantile", "deviance", "pearson")){
  type.residuals <- match.arg(type.residuals)
  alpha <- 1 - conf.level
  n <- length(object$residuals)
  r <- matrix(NA, nrow = B, ncol = n)
  for(b in 1:B){
    #set.seed(b)
    r[b, ] <- glm_boot(object)
  }
  limits <- t(apply(r, 2, function(x) quantile(x, probs = c(alpha/2, 1 - alpha/2))))
  colnames(limits) <- c("lower", "upper")
  r <- switch(type.residuals,
              deviance = rstandard(object, type = "deviance"),
              pearson = rstandard(object, type = "pearson"),
              quantile = qresiduals(object)
  )
  df <- data.frame(
    theoretical = stats::qnorm((seq_len(n) - 0.5) / n),
    sample = sort(r),
    limits
  )
  return(df)
}

