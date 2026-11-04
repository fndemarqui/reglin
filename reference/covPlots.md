# Covariates vs standardized residuals plots

Plots the standardized residuals against each covariate of the model.
Also called by
[`ggresiduals()`](https://fndemarqui.github.io/reglin/reference/ggresiduals.md)
when `type = "covPlots"`.

## Usage

``` r
covPlots(
  object,
  type.residuals = c("quantile", "deviance", "pearson"),
  variable = NULL
)
```

## Arguments

- object:

  an object of class `lm` or `glm`.

- type.residuals:

  type of residuals used for `glm` objects: `"deviance"`, `"pearson"` or
  `"quantile"`. Ignored for `lm` objects, for which standardized
  residuals are used.

- variable:

  optional character string with the name of a single covariate to plot;
  if `NULL` (default), all covariates are plotted.

## Value

Called for its side effect of drawing the plot(s).
