# ggplot version of influence diagnostic plots for an lm object

ggplot version of influence diagnostic plots for an lm object

## Usage

``` r
gginfluence(
  object,
  measure = c("leverage", "dfbetas", "cooksd", "dffits", "covratio"),
  ...
)
```

## Arguments

- object:

  an object of class lm with the fitted linear model.

- measure:

  the desired influence diagnostic measure; available options are:

  - leverage

  - dfbetas

  - cooksd

  - dffits

  - covratio

- ...:

  further arguments passed to other methods.

## Author

Fábio N. Demarqui
