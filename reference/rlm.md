# rlm: generation of data with a linear regression structure

rlm: generation of data with a linear regression structure

## Usage

``` r
rlm(formula, beta, sigma, data = NULL, ...)
```

## Arguments

- formula:

  a formula containing the linear predictor.

- beta:

  vector of regression coefficients.

- sigma:

  error standard deviation.

- data:

  a data.frame containing the set of covariates entering the linear
  predictor.

- ...:

  further arguments passed to other methods.

## Value

a numeric vector containing the generated response variable.
