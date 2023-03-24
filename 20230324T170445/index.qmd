---
title: Fonte de Recurso União
format:
  html:
    number-sections: true
execute:
  echo: false
toc: true
lang: pt
---

```{r}
library(tibble); library(knitr)
```

Esse conjunto de dados visa divulgar a matriz de correspondências entre as classificações orçamentárias vigentes no Estado de Minas Gerais e as codificações das fontes de recurso estabelecidas por meio da [Portaria Conjunta STN SOF nº 20/2021](https://www.in.gov.br/en/web/dou/-/portaria-conjunta-stn/sof-n-20-de-23-de-fevereiro-de-2021-304861747) e da [Portaria STN n° 710/2021](https://www.in.gov.br/en/web/dou/-/portaria-n-710-de-25-de-fevereiro-de-2021-305389863) (e [atualizações](https://www.gov.br/tesouronacional/pt-br/contabilidade-e-custos/federacao/fonte-ou-destinacao-de-recursos)).


## Leiaute arquivos

Os dois arquivos serão atualizados diariamente com as novas combinações de classificações orçamentárias[^20230202T143400] de receita e despesa que são criadas durante a execução orçamentária.

Algumas observações gerais:

1. Um segundo conjunto de dados (em leiaute a ser definido), será publicado com o código e descrição das fontes de recurso da Portaria STN n° 710/2021. O leiaute vai armazenar os históricos das descrições para permitir a correta divulgação das informações conforme classificações orçamnetárias vigentes à época.
1. Novas classificações orçamentárias podem ser adicionadas nas matrizes a partir da publicação de novas Portarias pela STN e/ou discussões do GT SEPLAG/SEF.

::: {.callout-note}

A divulgação em tranparência ativa de códigos e descrição das classificações orçamentárias acontece no via [Classificador Econômico da Despesa](https://www.mg.gov.br/planejamento/pagina/planejamento-e-orcamento/lei-orcamentaria-anual-loa/lei-orcamentaria-anual-loa). No entanto, o formato legível por máquina [hoje divulgado](https://docs.google.com/spreadsheets/d/1xP5V3dkvkXYIida6Wl6ERG-e2GA1XJwV/edit#gid=1757956794) não permite a identificação do período em que as descrições da classificação orçamentária estavam vigentes.

A sugestão é utilizar um formato que seja válido tanto para o classificador (a ser publicado no Portal de Dados Abertos), quanto para o processo específico relacionado a fonte de recurso da STN.

Uma sugestão de leiaute (que ainda carece de discussão e validação) é:

```{r}
#| label: tbl-classificador-economico
#| tbl-cap: Classificador Econômico da Desoesa

classificador <- tribble(
  ~CODIGO, ~DESCRICAO, ~DATA_INICIO_VIGENCIA, ~DATA_FIM_VIGENCIA,
  500, "Recursos Ordinários", "" , "2023-02-01",
  500, "Recursos não Vinculados", "2023-02-01", "2023-05-01",
  500, "Recursos não Vinculados de Impostos", "2023-05-01", ""
)

kable(classificador, "pipe")
```

A `DATA_FIM_VIGENCIA` da linha 1 é igual a `DATA_INICIO_VIGENCIA` da linha 2, indicando que em maio/2023 deve ser utilizada a descrição _"Recursos não Vinculados"_.

__Os valores ausentes de `DATA_INICIO_VIGENCIA` na linha 1 e `DATA_FIM_VIGENCIA` na linha 3 indicam que essa descrição se extende de forma indefinida.__ 
:::


[^20230202T143400]: Durante o exercício os órgãos e entidades fazem solicitações de liberação de receita, que consiste em uma autorização para arrecadação. Ou seja, são receitas que serão arrecadadas mas não foram previstas na Lei Orçamentária. Para a despesa, são publicados créditos adicionais, que são autorizações de despesas não fixadas na Lei de Orçamento ou que foram fixadas em valor insuficiente.

### Matriz de correspondência - Despesa {#sec-matriz-desp}

O leiaute da matriz de despesa é

<!-- ```
matriz_desp <- tribble(
  ~FONTE_STN, ~ANO, ~MES, ~UO, ~ACAO, ~GRUPO, ~FONTE, ~IPU,
  540, 2023, 1, 1261, 2066, 1, 23, 1,
  500, 2023, 1, 2061, 4204, 1, 10, 1,
  502, 2023, 2, 2061, 4204, 1, 10, 1,
)
``` -->

| FONTE_STN|  ANO| MES|   UO| ACAO| GRUPO| FONTE| IPU|
|-----------:|----:|---:|----:|----:|-----:|-----:|---:|
|         540| 2023|   1| 1261| 2066|     1|    23|   1|
|         500| 2023|   1| 2061| 4204|     1|    10|   1|
|         502| 2023|   2| 2061| 4204|     1|    10|   1|

: Matriz Despesa {#tbl-matriz-desp}

Observações:

1. Independentemente de quando uma nova linha é adicionada na matriz @tbl-matriz-desp, os empenhos correspondentes devem ter sua `FONTE_STN_COD` atualizada;
1. Os empenhos registrados na classificação `1261|2066|1.23.1` devem ser classificados na `FONTE_STN_COD` 540 de janeiro/2023 em diante;
1. Os empenhos registrados na classificação `2061|4204|1.10.1` devem ser classificados na `FONTE_STN_COD` 502 somente a partir de fevereiro de 2023;
1. __Os empenhos registrados em classificações que não estão presentes na matriz devem ser exibidos com a `FONTE_STN_COD` 898, Recursos a Classificar.__

### Matriz de correspondência - Receita

O leiaute da matriz de receita é

```{r}
#| label: tbl-planets
#| tbl-cap: Matriz Receita

matriz_rec <- tribble(
  ~FONTE_STN, ~ANO, ~MES, ~UO, ~FONTE, ~RECEITA,
  552, 2023, 1, 1261, 36, 1922,
  501, 2023, 1, 2371, 60, 1321,
)

kable(matriz_rec, "pipe")
```

As mesmas observações realizadas na seção @sec-matriz-desp para os empenhos são válidas para os registros de arrecadação da receita.

