

qhalfnorm <- function(p) {
  stats::qnorm((p + 1) / 2)
}

phalfnorm <- function(q) {
  2 * stats::pnorm(q) - 1
}

dhalfnorm <- function(x, log = FALSE) {
  res <- 2 * stats::dnorm(x)
  res[x < 0] <- 0
  if (log) log(res) else res
}


rhalfnorm <- function(n) {
  abs(stats::rnorm(n))
}







