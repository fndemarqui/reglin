# Queda de tensão da bateria em um motor de míssil guiado

Exemplo: Dados referentes à queda de tensão da bateria em um motor de
míssil guiado observada durante o voo do míssil. O diagrama de dispersão
sugere que a queda de tensão se comporta de maneira diferente em
diferentes segmentos de tempo e, portanto, modelaremos os dados com um
spline cúbico usando dois nós em t1 = 6,5 e t2 = 13 segundos após o
lançamento, respectivamente.

## Format

Data frame com 41 linhas e duas variáveis:

- tempo: tempo após o lançamento (em segundos)

- tensao: queda de tensão (Volt)

## References

Montgomery, D. C., Peck, E. A., and Vining, G. G. (2012) Introduction to
Linear Regression Analysis, 5th Edition, Boca Raton: Wiley.

## Author

Fábio N. Demarqui <fndemarqui@est.ufmg.br>
