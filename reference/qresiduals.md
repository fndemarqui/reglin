# Quantile residuals

Computes (randomized) quantile residuals for `lm` and `glm` objects. For
`lm` objects, standardized residuals are returned. For `glm` objects,
the method depends on the family: binomial, poisson, Negative Binomial,
Bell, Gamma, inverse Gaussian; other families use a default standardized
deviance residual. Code adapted from the statmod package.

## Usage

``` r
qresiduals(glm.obj, dispersion = NULL)
```

## Arguments

- glm.obj:

  an object of class `lm` or `glm`.

- dispersion:

  optional dispersion parameter; if `NULL`, it is estimated from the
  model. Only used for the Gamma, inverse Gaussian and default methods.

## Value

A numeric vector with the quantile residuals.

## Details

Residuals for discrete distributions are randomized, so results vary
between calls unless a seed is set.

## References

Dunn, P. K. and Smyth, G. K. (1996). Randomized quantile residuals.
*Journal of Computational and Graphical Statistics*, 5, 236-244.

## Author

Peter K. Dunn and Gordon Smyth (original code in statmod).
