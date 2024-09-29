#' ENIGH Nueva Construccion (2018-2022)
#'
#' Descarga datos de la Encuesta Nacional de Ingreso y Gasto de los Hogares, Nueva Construccion (2018-2022).
#'
#' La ENIGH provee informacion estadisticas sobre los ingresos y gastos de los hogares en cuanto a su monto, procedencia y distribucion. Adicionalmente, la ENIGH provee informacion sobre las caracteristicas socio-demograficas de los integrantes del hogar.
#'
#' @param year Año de levantamiento de la encuesta en formato numerico. Los años disponibles son 2018, 2020, 2022
#' @param datos Base de datos a descargar "viviendas" "hogares" "concentrado" "erogaciones" "gastohogar" "gastotarjetas" "poblacion" "ingresos" "gastopersona" "trabajos" "agro" "noagro"
#' @param formato Formato del archivo, 'csv' 'dbf' 'sav' 'dta'
#' @param extdir Si se descomprimirá en algún directorio externo
#' @examples
#'
#' # Descargar datos de hogares
#' \dontrun{hogares14 = enigh_nuevaconstruccion(year = 2014,  datos = "hogares")}
#' @return Data.frame
#' @export
#'
#'
enigh <- function(year = NA, datos = '', formato = 'dbf', extdir = ''){
  link.base = 'https://www.inegi.org.mx/contenidos/programas/enigh/nc/'

  # Construcción del enlace
  link = paste0(link.base, year, '/microdatos/enigh', year, '_ns_', datos, '_', formato, '.zip')
  print(link)
  temp.enigh = base::tempfile()
  utils::download.file(link, temp.enigh)

  # Definir el directorio de extracción
  if (extdir == '') {
    extdir = tempfile()
  }

  # Extraer el archivo y obtener las rutas extraídas
  unzipped_files = utils::unzip(temp.enigh, junkpaths = TRUE, exdir = extdir)

  # Imprimir los archivos extraídos
  data = rio::import(unzipped_files)

}


