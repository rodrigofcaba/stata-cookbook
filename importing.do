********************************************************************************
**                            IMPORTANDO DATOS                                **
********************************************************************************


* Stata puede importar datos en diferentes formatos. Los dos más comunes son 
* archivos de texto (comma-separated values = csv), y archivos de Excel. En general
* todos los datos son o presentados en uno de esos dos fotmatos, o pueden ser
* exportados en uno de esos dos formatos.



** ATENCIÓN

* ¡Antes de importar nuevos datos, asegúrate de que los datos se han guardado
* y que has limpiado la memoria de Stata!



** ARCHIVOS DE TEXTO SEPARADOS POR COMAS (CSV)

* La forma "menos complicada" es importar datos desde un archivo de texto. Este
* es un formato de archivo muy plano que no requiere mucho espacio en el disco,
* y Stata es suficientemente inteligente leyendo este formato de archivo. 
* Normalmente, simplemente puedes importarlo con:

import delimited "filename.csv"

* Stata tratará la primera fila como los nombres de las variables,
* detectará los tipos de variables automáticamente e importará todas
* las observaciones en la memoria.

* Asegúrate de comprobar tus datos después de importarlos, presta especial
* atención a los siguientes problemas:

*  1  ¿Están los nombres de las variables bien? Si no, importa o etiqueta de nuevo.
*  2  ¿Son las variables numéricas realmente numéricas? Si no, trata de encontrar
*     el origen del problema, ej. comas decimales cuando Stata espera
*     puntos como decimales. Resuelve estos problemas y después usa
      destring variablename, replace
*     para resolver el problema anterior. ¿No se ha arreglado? Prueba a 
*     importar de nuevo usando el menú de importación.
*  3  Comprueba si las variables categóricas se muestran como números. Si
*     es así, quizás quieras darle a cada categoría una etiqueta (ver labeling.do).
*  4  Comprueba que todas las observaciones se importaron. Si falta algo,
*     prueba a importar de nuevo usando el menú de importación.

* Como puedes comprobar, una aproximación para solucionar fácilmente el problema es
* importar primero con "import delimited" y, si aparecen problemas, volver al menú
* que puedes encontrar en Archivo > Importar > Archivo de texto separado por comas
* en el menú de Stata. Usar este menú te permite ajustar todas las opciones de
* importación a la vez que tienes una previsualización de cómo son los datos que van
* a ser importados. Una vez que estás contento/a con los ajustes, el menú de importación
* producirá el comando correspondiente. Asegúrate de que tienes la función "log"
* encendida para que puedas "capturar" el comando correcto.


** MICROSOFT EXCEL

* La manera "ligeramente más complicada" es importar los datos desde un libro de Excel
* Stata puede trabajar con archivos de Excel antiguos y nuevos (.xls y, xlsx, respectivamente.
* Dado que los libros de Excel pueden contener multiples hojas y, dado que cada
* hoja puede contener múltiples tablas, debes especificar dónde está la tabla
* que quieres importar proporcionando el nombre de la hoja y las celdas que se
* encuentran en la esquina superior izquierda e inferior derecha de la tabla.

* Abre tu libro de Excel y anota el nombre de la hoja. Los archivos de excel creados en
* inglés, en un ordenador con Mac o Windows, suelen nombrar las hojas "Sheet1",
* "Sheet2", etc. Sin embargo, estas etiquetas son diferentes si el libro se creó en
* un ordenador en otro idioma, y, además, el usuario puede cambiar los nombres de las hojas.
* Lo mejor es copiar el nombre en el portapapeles: doble click encima del nombre de la hoja
* (aparece en la pestaña en la parte inferior de la ventana de Excel). El nombre se
* subrayará y puede copiarse y pegarse en el comando de Stata de abajo.

* A continuación, comprueba si tu tabla tiene los nombres de las variables sólo en la
* primera fila.  Stata sólo acepta nombres de variables en la fila de más arriba,
* pero Excel no tiene esta restricción. Si tienes nombres de variables en más de una fila,
* ajusta tu tabla de manera que la fila de más arriba tenga nombres de variables claros
* y únicos, y que el resto de filas sean observaciones individuales.

* Finalmente, apunta la celda superior izquierda y la celda inferior derecha de
* la tabla que quieres que Stata importe. Por ejemplo, si tienes una tabla que empieza
* en la celda de más arriba y a la izquierda de la hoja y tiene diez columnas y diez filas,
* la celda superior izquierda será A1 y la celda inferior derecha será J10.

* Adapta el comando de abajo con el nombre y el rango conrrecto para importar
* la tabla desde Excel:
import excel "filename.xlsx", sheet("Sheet1") cellrange(A1:J10) firstrow

* Si sólo tienes observaciones y ningún nombre de las variables, debes eliminar
* la opción "firstrow".

* Si tienes problemas importando desde Excel con los pasos de arriba, usa el menú
* de importación en Archivo > Importar > Hoja de cálculo de Excel en el menú de Stata.
* Este menú te permite seleccionar la hoja correcta e introducir el rango de 
* celdas correcto; a su vez, te ofrece una previsualización de qué va a importar Stata
* para que puedas comprobar que los ajustes son correctos.


** OTRO TIPO DE ARCHIVOS
* Stata permite importar desde otro tipo de archivos, incuyendo XML (un formato 
* cada vez más usado para datos en internet), SAS (un paquete stadístico diferente), 
* y varios archivos de texto.

* No necesitarás usar esos tipos de archivos en el futuro cercano, y son comparativamente
* extraños. Recomendamos dos opciones:

*  1  Si es posible, exporta o convierte estos archivos a formato Excel o CSV.
*     Estos formatos son sudicientemente estándar y se "comportan" suficientemente
*     bien, así que añadir este paso normalmente hace el proceso mucho menos complicado

*  2  Usa los mecanismos de importación individual que ofrece el menú de Stata en
*     Archivo > Importar. Los menús específicos te guiarán a lo largo del proceso
*     de importar los datos que necesites y habitualmente te permiten ver una
*     previsualización de cómo quedarán los datos importados para que puedas comprobar
*     si hay algún problema. Asegúrate de que estás usando "log" mientras importas,
*     para que el "log" capture el comando correcto.



** IMPORTAR DATOS DESDE BASES DE DATOS

* Stata puede conectarse directamente a bases de datos. Esto normalmente requiere
* ajustes específicos que permitan localizaar la base de datos (normalmente en un
* servidor de internet), cualquier nombre de usuario y contraseña que puedan ser
* necesarios para obtener acceso y cómo Stata debería comunicarse con la base de datos.

* Si necesitas conectarte a una base de datos, asegúrate de que tienes la
* documentación específica para esa base de datos y usa el comando "odbc" para
* conectarte. Puedes encontrar más información aquí:
help odbc