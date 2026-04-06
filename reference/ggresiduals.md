# ggplot version of plot diagnostics for an lm object

ggplot version of plot diagnostics for an lm object

## Usage

``` r
ggresiduals(
  object,
  type = c("default", "crPlots", "avPlots", "covPlots"),
  which = 1:4,
  alpha = 0.05,
  ...
)
```

## Arguments

- object:

  an object of class lm with the fitted linear model.

- type:

  the desired type of plot; available options are:

  - default: for default R residual plots

  - crPlots: for component + residuals plots

  - avPlots: for added variable plots

  - covPlots: for covariates vs stdresidual plots

- which:

  only used for the default type of plot; a subset of the numbers 1:6,
  by default 1:4, referring to:

  1.  Residuals vs Fitted

  2.  Normal Q-Q" plot

  3.  Scale-Location

  4.  Cook's distance

  5.  Residuals vs Leverage

  6.  Cook's dist vs Lev./(1-Lev.)

- alpha:

  significance level used to determined inconsistent points in plot 5;
  default value is alpha = 0.05.

- ...:

  further arguments passed to other methods.

## Author

Fábio N. Demarqui
