
#' Pureza do oxigênio
#'
#' @name pureza
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Exemplo: Um engenheiro está interessado em estudar a relação entre a pureza do oxigênio (y) produzido em um processo químico de destilação e o percentagem de hidrocarbonetos (x) presente no condensador principal de uma unidade de destilação.
#' @format Data frame com 20 linhas e duas variáveis:
#' \itemize{
#'   \item percentual: percentual de hidrocarbonetos presentes no condensador principal (covariável)
#'   \item pureza: purezao do oxigênio (variável resposta)
#' }
#' @references  Montgomery, D. C., Runger, G. C. (2015) Estatística Aplicada e Probabilidade para Engenheiros, 5ª. Edição, Rio de Janeiro: LTC.
#'
NULL


#' Geração de energia
#'
#' @name moinho
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Exemplo: Um engenheiro de pesquisa está investigando o uso de um moinho de vento para gerar eletricidade. Ele coletou dados sobre a tensão de saída de seu moinho de vento e a velocidade do vento correspondente.
#' @format Data frame com 25 linhas e duas variáveis:
#' \itemize{
#'   \item velocidade: velocidade do vento (covariável)
#'   \item tensao: tensão de saída (variável resposta)
#' }
#' @references  Montgomery, D. C., Peck, E. A., and Vining, G. G. (2012) Introduction to Linear Regression Analysis, 5th Edition, Boca Raton: Wiley.
#'
NULL


#' Força de fibras de monofilamento
#'
#' @name fibras
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Delineamento com um fator fixo e uma covariável conduzido para avaliar se existem diferenças na forças de fibras de monofilamentos produzidas por 3 máquinas.
#' @format Data frame com 15 linhas e 3 variáveis:
#' \itemize{
#'   \item força: força da fibra de monofilamento (variável resposta)
#'   \item maquina: máquina utilizada na produção das fibras de monofilamento (variável categórica com três níveis; fator de interesse principal)
#'   \item diametro:  diâmetro da fibra de monofilamento (covariável; interesse secundário)
#' }
#' @references  Montgomery, D. C. (2016). Design and Analysis of Experiments, 8ª. Edição, New York: Wiley.
#'
NULL


#' Longevidade de moscas-das-frutas
#'
#' @name moscas
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Em um experimento 125 moscas-das-frutas que foram divididas aleatoriamente em 5 grupos de 25 cada. A resposta foi a longevidade da mosca-da-fruta em dias. Um grupo foi mantido solitário (A), enquanto outro foi mantido individualmente com uma fêmea virgem a cada dia (B). Outro grupo recebeu 8 fêmeas virgens por dia (C). Como controle adicional, o quarto (D) e quinto (E) grupos foram mantidos com uma ou oito fêmeas grávidas por dia. As moscas-das-frutas grávidas não acasalam. O comprimento do tórax de cada macho foi medido, pois isso era conhecido por afetar a longevidade. Uma observação no grupo D foi perdida.
#' @format Data frame com 124 linhas e 3 variáveis:
#' \itemize{
#'   \item torax: comprimento do tórax de cada macho (covariável)
#'   \item longevidade:  longevidade da mosca-da-fruta em dias (variável resposta)
#'   \item grupo:  grupos de interesse para comparação (covariável)
#' }
#' @references
#'
#' \insertRef{faraway}{reglin}
#'
NULL


#' Isolamento térmico de casa e consumo de gás
#'
#' @name gas
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Derek Whiteside, da Estação de Pesquisa de Edifícios do Reino Unido, registrou o consumo semanal de gás e a temperatura externa média em sua própria casa no sudeste da Inglaterra para duas estações de aquecimento, uma de 26 semanas antes e uma de 30 semanas após a instalação do isolamento térmico nas paredes da sua residência. O objetivo do exercício foi avaliar o efeito do isolamento térmico no consumo de gás.
#' @format Data frame com 56 linhas e 3 variáveis:
#' \itemize{
#'   \item isolamento: variável indicadora (antes/depois) da instalação do isolamento  (covariável)
#'   \item temperatura:  temperatura externa medida em graus Celsius (covariável)
#'   \item consumo: consumo semanal de gás em metros cúbicos  (variável resposta)
#' }
#' @references
#'
#' \insertRef{MASS}{reglin}
#'
NULL


#' Tamanho de ouriços
#'
#' @name ouricos
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Um experimento foi realizado com o objetivo de determinar como três regimes de alimentação diferentes (A, B e C) afetam o tamanho de ouriços-do-mar ao longo do tempo. O tamanho inicial dos ouriços-do-mar no início do experimento provavelmente afeta o tamanho que eles crescem à medida que são alimentados, e portanto foi considerado uma variável de perturbação.
#' @format Data frame com 72 linhas e 3 variáveis:
#' \itemize{
#'   \item regime: regime de alimentação: A, B ou C (covariável)
#'   \item tamanho_inicial: tamanho do ouriço antes do início da dieta (covariável)
#'   \item tamanho_final: tamanho do ouriço no final do experimento (variável resposta)
#' }
#' @source \href{https://www.tidymodels.org/start/models/}{tidymodels}
#'
NULL



#' Efeito de propaganda sobre as receitas de restaurantes
#'
#' @name restaurantes
#' @docType data
#' @author Fábio N. Demarqui \email{fndemarqui@est.ufmg.br}
#' @keywords datasets
#' @description Exemplo: Um estudo foi realizado para avaliar o impacto do gasto anual com propagana sobre o rendimento médio mensal da venda de alimentos de 30 restaurantes.
#' @format Data frame com 3 linhas e 3 variáveis:
#' \itemize{
#'   \item receita: receita média mensal do restaurante (variável resposta)
#'   \item propaganda: gasto anual com propaganda (covariável)
#'   \item id: indicadora de grupo de restaurantes
#' }
#' @references  Montgomery, D. C., Peck, E. A., and Vining, G. G. (2012) Introduction to Linear Regression Analysis, 5th Edition, Boca Raton: Wiley.
#'
NULL
