# PRESS statistic

Function to compute PRESS statistic for one or more models.

## Usage

``` r
press(object, ...)
```

## Arguments

- object:

  one or more objects of class lm.

- ...:

  further arguments passed to or from other methods.

## Value

the PRESS statistic when a single model is passed to the function;
otherwise, a data.frame with the PRESS statistic values is returned.

## Examples

``` r
# \donttest{
library(reglin)
data(entregas)

fit0 <- lm(tempo ~ 1, data = entregas)
fit1 <- lm(tempo ~ caixas, data = entregas)
fit2 <- lm(tempo ~ distancia, data = entregas)
fit3 <- lm(tempo ~ caixas + distancia, data = entregas)
fit4 <- lm(tempo ~ caixas*distancia, data = entregas)

press(fit1)
#> [1] 733.55
press(fit1, fit2, fit3, fit4)
#>    fit     press
#> 1 fit4  243.0798
#> 2 fit3  459.0393
#> 3 fit1  733.5500
#> 4 fit2 1731.2414
# }
```
