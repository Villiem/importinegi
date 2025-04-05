#' ENIGH Nueva Construccion (2018-2022)
#'
#' Descarga datos de la Encuesta Nacional de Ingreso y Gasto de los Hogares, Nueva Construccion (2018-2022).
#'
#' La ENIGH provee informacion estadisticas sobre los ingresos y gastos de los hogares en cuanto a su monto, procedencia y distribucion. Adicionalmente, la ENIGH provee informacion sobre las caracteristicas socio-demograficas de los integrantes del hogar.
#'
#' @param year Año de levantamiento de la encuesta en formato numerico. Los años disponibles son 2018, 2020, 2022
#' @param datos Base de datos a descargar "viviendas" "hogares" "concentradohogar" "erogaciones" "gastohogar" "gastotarjetas" "poblacion" "ingresos" "gastopersona" "trabajos" "agro" "noagro"
#' @param formato Formato del archivo, 'csv' 'dbf' 'sav' 'dta'
#' @param extdir Si se descomprimirá en algún directorio externo
#' @examples
#'
#' # Descargar datos de hogares
#' \dontrun{pob = enigh(year = 2022,  datos = "poblacion")}
#' @return Data.frame
#' @export
#'
#'
enigh <- function(year = NA, datos = '', formato = 'dbf', extdir = ''){
  # Validar parámetros
  valid_years <- c(2018, 2020, 2022)
  if(is.na(year) || !year %in% valid_years) {
    stop("El year debe ser ", paste(valid_years, collapse=", "))
  }

  if(datos == '') {
    stop("El parámetro 'datos' es obligatorio")
  }

  # Construcción del enlace
  link.base = 'https://www.inegi.org.mx/contenidos/programas/enigh/nc/'
  link = paste0(link.base, year, '/microdatos/enigh', year, '_ns_', datos, '_', formato, '.zip')
  print(link)

  # Descargar el archivo
  temp.enigh = base::tempfile()
  utils::download.file(link, temp.enigh)

  # Definir el directorio de extracción
  if (extdir == '') {
    extdir = tempfile()
  }

  # Extraer el archivo y obtener las rutas extraídas
  unzipped_files = utils::unzip(temp.enigh, junkpaths = TRUE, exdir = extdir)

  # Importar los datos
  if(length(unzipped_files) == 0) {
    stop("No se encontraron archivos en el ZIP")
  } else if(length(unzipped_files) == 1) {
    data = rio::import(unzipped_files[1])
  } else {
    # Si hay múltiples archivos, podemos usar el primero o hacer algo más sofisticado
    # como buscar por nombre específico
    message("Se encontraron múltiples archivos. Importando el primero...")
    data = rio::import(unzipped_files[1])
  }

  # Retornar explícitamente
  return(data)
}
