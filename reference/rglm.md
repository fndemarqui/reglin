# rglm: data generation for generalized linear models

rglm: data generation for generalized linear models

## Usage

``` r
rglm(formula, beta, family, phi = NULL, data = NULL, ...)
```

## Arguments

- formula:

  a formula containing the linear predictor.

- beta:

  vector of regression coefficients.

- family:

  a character string or a family object specifying the distribution of
  the response variable.

- phi:

  dispersion parameter.

- data:

  a data.frame containing the set of covariates entering the linear
  predictor.

- ...:

  further arguments passed to other methods.

## Value

a numeric vector containing the generated response variable.
