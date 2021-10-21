********************************************************************************
**                   USO BÁSICO DE LA LÍNEA DE COMANDOS                       **
********************************************************************************

* Para el propósito de este cookbook introductorio, utilizamos un solo comando:
* summarize. Este comando proporciona estadísticas descriptivas básicas para una
* o más variables de un conjunto de datos, incluyendo el número de observaciones,
* su valor medio y la desviación típica, así como el valor más grande y el más 
* pequeño.

* Todos los ejemplos se basan en la encuesta de hogares de Kirguistán y,
* en particular, en la base de datos POVERTY.dta.



* UTILIZANDO UNA O MÁS VARIABLES
* La mayoría de los comandos pueden aplicarse a una o más variables. Para aplicar 
* el comando a TODAS las variables, introduzca sólo el comando:

summarize

* Para aplicar el comando a variables individuales, enumérelas después del comando,
* separadas por un espacio:

summarize toty totx

* Puedes utilizar símbolos comodín para ahorrarte el tener que teclear. El asterisco
* representa cualquier carácter o caracteres (uno o varios). Por ejemplo:

summarize y*

* ... es lo mismo que enumerar cada una de las variables cuyo nombre empieza por Y:

summarize y1 y2 y3 y5 y6 y7 y8 y9 y10 y11 y12 y13 y41 y42 y42 y44 y45 y46

* Otro comodín es el signo de interrogación que representa un carácter cualquiera:

summarize y?3

* es lo mismo que enumerar cada una de las variables cuyo nombre empezaba por una Y,
* seguido de cualquier carácter y que termine con un 3:

summarize y13 y43



* ABREVIATURA DE LOS NOMBRES DE LAS VARIABLES
* En Stata se trata de ahorrarte algo de tecleo. Los comandos más comunes pueden ser
* abreviados mucho, por ejemplo, summarize puede ser abreviado a "su". Escribir:

su toty

* es lo mismo que escribir

summarize toty

* Si quieres saber si puedes abreviar el nombre de una variable, utiliza la función 
* help

help summarize

* En la sintaxis, la versión abreviada del nombre de la variable aparecerá subrayada.


* UTILIZANDO TODAS LAS OBSERVACIONES O UN SUBCONJUNTO
* Por defecto, Stata aplicará el comando a todas las observaciones de la variable,
* posiblemente excluyendo los valores perdidos. Pero a veces no se quieren
* todas las observaciones, sino sólo un subconjunto. Por ejemplo, el siguiente comando
* proporciona un resumen de las variables de ingresos y gastos totales de los hogares.

summarize toty totx


* Pero quizás solo te interesan los hogares en zonas rurales o urbanas.
* La variable b002 te dice si un hogar está en un área urbana(1) o rural (2).
* Este comando resume ingresos y gastos para hogares urbanos diciéndole
* a Stata que sólo incluya las observaciones pora las que el indicador 
* del área tenga el valor correcto:

* Aquí están los valores resumidos para los hogares urbanos:

summarize totx toty if b002 == 1

* ... y aquí para los hogares rurales:

summarize totx toty if b002 == 2

* Por lo general, encontrará que los hogares rurales tienen una renta media más baja y
* gastos medios más elevados. Tiene sentido.

* Se puede forzar a Stata a tomar un subconjunto de observaciones que cumpla con múltiples
* condiciones al mismo tiempo (Y lógico). El siguiente comando nos da los hogares rurales,
* sin niños menores de 14 años viviendo en casa. Usamos el carácter & para decir AND:

summarize totx toty if b002 == 2 & child14 == 0

* Los gastos medios suelen ser inferiores a la media de todos los
* hogares rurales. Tiene sentido.

* También puede asegurarse de que Stata compruebe si una de varias condiciones se
* se cumple (O lógico). El siguiente comando nos da todos los hogares que
* tienen algún ingreso por trabajo (salario):

summarize totx toty if y1 > 0

* Y este comando nos da todos los hogares que tienen algún ingreso de las pensiones:

summarize totx toty if y2 > 0

* Este comando nos da aquí todos los hogares que tienen ingresos por trabajo O por
* pensiones. Utilizamos una barra para decir "O":

summarize totx toty if y1 > 0 | y2 > 0

* ¿Notas algo? La cantidad total de hogares con algún tipo de ingresos procedentes 
* de cualquiera de los dos (4801) es inferior a la suma de los hogares que tienen
* ingresos del trabajo (4069) y de las pensiones (2307). Lógicamente, debe haber
* 1.575 hogares que tienen algún ingreso del trabajo y ¡adicionalmente algún 
* ingreso por pensiones!



* AUTOCOMPLETAR LOS NOMBRES DE LAS VARIABLES
* Fíjate en que puedes utilizar el tabulador para completar el nombre de una variable. 
* Esto funciona bien si el nombre de variable es único (no se puede confundir con otro).
* Prueba a escribir "summarize xs" y luego pulsa la tecla de tabulación -->| Obtendrás:

summarize xserv 

* Si hay varios potenciales nombres diferentes, Stata no hará nada.
* Prueba a escribir "summarize y1" y luego pulsa el tabulador. Stata
* no hará nada. Esto es porque podrías querer decir y1, y10, y11, y12
* o y13 -- Y Stata no sabe cuál de ellas quieres.

* Si hay varias opciones, pero Stata puede ahorrarte algo de tecleo,
* irá hasta la letra donde tiene que hacer una
* elección: Prueba a teclear "resumir qui" y luego pulsa la tecla de tabulación -->|
* Obtendrás:

summarize quintil

* Eso es porque hay dos variables posibles: quintilc y
* quintilx. Stata no sabe cuál quieres, pero
* autocompletará a quintil y te dejará la elección de la letra final a ti.




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




********************************************************************************
**                            LOGGING STATA OUTPUT                            **
********************************************************************************

* For reproducibility, it is essential to keep a complete log of what your
* analyses. Stata offers logging functions that automate this task for you --
* the only thing you need to do is switch on the log at the start of each
* analysis and switch it off at the end. In between these two commands, Stata
* will write the following things to the log file:
* _1_ Every command you type or run from a do-file
* _2_ Every comment you make or including in a do-file (handy for annotations!)
* _3_ All output that your commands generate except for graphs.



** OPENING YOUR LOG FILE -- Pretty straightforward:

* This command starts logging immediately in the specified file name
log using "my log filename.log"

* Be sure to include the file name in quotation marks except if the filename is
* one word only.

* Stata knows two file formats for logs, we strongly recommend plain text log
* files, since you can open them in any text editor or word processor like
* Microsoft Word or LibreOffice. As you as the file name ends on .log, Stata
* will save the log in the correct format. However, you can force Stata to play
* nice by explicitly telling it to save the log as text:
log using "my log filename.log", text



* If you using the same log file for analysis in multiple sessions, Stata will
* complain if you are at risk of overwriting an existing file. This forces you
* to choose what you want to do:

* You can CONTINUE the old log file:
log using "my log filename.log", append
* All information in the log file is kept and all new information is added to
* the end of the log file. This is the better option in most circumstances,
* since it avoids any data loss.

* You can OVERWRITE the old log file:
log using "my log filename.log", replace
* You lose everything contained in the log file at this point, so you should
* only use this option if you are sure you can afford to lose this information!



* An easy way to avoid potential data loss is to give each log file a file name
* that includes the date and time when the analysis was started. You can do this
* automatically with the command:
log using "Log `c(current_date)' `c(current_time)'.log"

* Feel free to change the name of the log, but make sure to keep the commands
* for date and time -- `c(current_date)' and `c(current_time)' -- in the file
* name.



* We recommend giving each log file a name:
log using "Log `c(current_date)' `c(current_time)'.log", name("HELPFUL NOTE")
* The name is printed at the very top of the log file and allows you to leave a
* note to your future self about what you are doing in this log file.



* Are you doing unspeakable things to your data that you don't want to record?
* You can pause the log to exclude a part of your analysis from the log:
log off
* All done and want to switch the log back on?
log on

* This is particularly useful if you are exploring or tinkering with your data
* and don't need an actual log of what you are doing. However, there is no harm
* in keeping the log running at all times. Who knows? You might find something
* useful when playing with the data, and if the log isn't on, you don't have a
* record of it...



* At the end of your analysis, you should close your log properly:
log close _all

* This ensures that your log file is properly written to disk. Using _all here
* tells Stata to close any log, independent of the helpful name we have given
* it above.




********************************************************************************
**                       LABELING VARIABLES AND VALUES                        **
********************************************************************************

* It is essential that variables and values in your data set are carefully named
* and labeled. Good variable names reduce the amount of typing you have to do,
* good variable labels help you (in the future) to remember what information is
* contained in each variable, and correct value labels make sure that
* categorical information is correctly understood and analyzed.



** (RE-)NAMING YOUR VARIABLES -- Especially when importing data from other
* sources, you may find that the variable names are not as succinct as they
* could be.

* You can easily rename variables using:
rename oldname newname
* As long as the oldname correctly identifiea an existing variable and the new
* name is an acceptable name, Stata will rename the variable for you.

* The abbreviated version of "rename" is "ren":
ren old new

* As an example, let's say that we got household data that includes the number
* of children under 5 and under 14 in a household, and the data was in an Excel
* sheet with the very clear, but verbose variable names:
*     No. of children aged <=5
*     No. of children aged <=14
* Upon importing the data into Stata, the variable names become:
*     noofchildrenaged5
*     noofchildrenaged14
* This is hard to read and cumbersome to type. We could rename these variables
* to something shorter, but still sufficiently clear:
rename noofchildrenaged5 child5
rename noofchildrenaged14 child14

* You will want to rename your variables right after importing, so that all
* future commands use the new names consistently. If you rename variables in the
* middle of your do-file, you may have commands referring to the same variable
* but using the old name before the renaming command and the new name after the
* renaming command. Because these names are different, somebody reading your
* code will have a harder time seeing that you are working with the same
* variable. Ergo: rename right after import.

* Nota bene:
* For the KIHS, the names are already pretty good, because the dataset is
* created by professional statisticians who understand the ways in which
* statistical packages tend to work. We request that you stick to the original
* variable names so that we have an easier time reading your do-file.



** LABELING YOUR VARIABLES -- In Stata, variable names are meant to be short and
* to the point, so that they quick to type and easy to understand. However, 
* variable names are usually to brief to contain all information you will need.
* For this reason, Stata offers variable labels, which can contain a lot more
* information.

* Ideally, even the simplest variables should have a label and we encourage
* proper labeling in every dataset you work on. While you may not be creating
* data sets that will be distributed to many users (yet!), you do have one all-
* important constituent who needs to understand your data: yourself in the
* future. Careful labeling helps you understand your own data set when you come
* back to it in a few weeks, months or even years. If you label your data now,
* you won't have to travel back in time to punish yourself for making your own
* life harder.

* There's an additional benefit to labeling data: writing good variable labels
* forces you to think carefully about what each variable contains. If something
* is unclear to you know (e.g. what currency is this income data in?), you can
* probably investigate and fix this problem, or you are at least aware that a
* problem exists and needs to be taken into account when interpreting the data.

* To give any variable a label, use:
label variable some_variable "Description of the variable, up to 80 characters"

* The abbreviated version is:
la var variable "Description of the variable, up to 80 characters"


** LABELING VALUES OF CATEGORICAL VARIABLES -- Many datasets contain categorical
* variables which are stored as numerical codes that have an assigned meaning.
* Labeling the values is what tells Stata (and the users of the data set) which
* numerical code stands for which meaning.

* Assigning value labels proceeds in two steps. First, you create a list of the
* numerical codes (or values) and their label appropriate label:
label define name_of_this_set_of_values 1 "What does 1 stand for?" 2 "What..."
* Then, you tell Stata to use this set of labels on a particular variable
label values variable_name name_of_this_set_of_values

* We might have a marital status variable with different categories:
label define statuslabels 0 "not married" 1 "married" 2 "divorced" 3 "widowed"
label values maritalstatus statuslabels

* The abbreviated versions of this commands are "la de" and "la val":
la de genderlabels 0 "male" 1 "female"
la val gender genderlabels

* Your set of value labels can contain tens of thousands of value-label pairs.



** THE CODEBOOK -- If you have received a properly labeled dataset from a source
* or if you labeled a dataset yourself, you can use the
codebook
* command to get a comprehensive overview of all variables. For each variable,
* you will get the name, the label, the type of the variable, and useful
* summary statistics such as the number of missing observations, the range,
* average, standard deviation and percentiles (for numeric information), or a
* tabulation (for categorical information).

* Especially when getting a new dataset or refreshing your memory of an existing
* dataset, this should be your go-to command.




********************************************************************************
**                                  GRAPHING                                  **
********************************************************************************

* One of the best ways for understanding a dataset is to make graphs for its
* various variables. Stata offers a number of graphing commands 


** GRAPHING CATEGORICAL DATA (PIE CHART) -- Pie charts are useful for showing
* how 100% of something are distributed among various categories. A draw-back of
* pie charts is that visual comparison between similarly sized categories is not
* easy -- but otherwise, they are easy to interpret.

* To devide information by categories, Stata uses the over option. In our
* dataset, the variable "priz" contains information about the terrain (flat vs.
* mountainous). Here is a pie chart based on the frequencies of each terrain
* category:
graph pie, over(priz)

* By default, the pie chart comes with a legend if the variable has value labels
* assigned. You can customize the appearance -- see below in this text, or in
* the documentation under
help graph pie

* The abbreviated version of "graph pie" is "gr pie":
gr pie, over(priz)

* You can order the slices from smallest to largest (starting at 12 o'clock and
* going clockwise) by adding the "sort" option:
graph pie, over(priz) sort

* If you prefer to go from largest to smallest, also add "descending":
graph pie, over(priz) sort descending



** GRAPHING CATEGORICAL DATA (BAR CHART) -- Bar charts can fulfill the same task
* for categorial data as pie charts, and have the added advantage that the size
* of similar categories can be more easily perceived.

* The command works the same way as "graph pie":
graph bar, over(priz)

* The abbreviated version of "graph bar" is "gr bar":
gr bar, over(priz)

* If the variable has value labels, they will be used to label the bars for each
* category.

* By default, bar charts have the categories along the x-axis, with bars growing
* upward. The y-axis is labeled in percent for the relative shares of each
* category. If you would like to change the orientation, with the categories
* along the y-axis and percentage along the x-axis, you can use "hbar" instead
* of "bar":
graph hbar, over(priz)

* You can customize the appearance of the bar chart further. See below in this
* text, or in the documentation under
help graph bar


** GRAPHING QUANTITATIVE DATA (HISTOGRAM) -- Histograms are very useful for
* quantitative information because break the entire range of values into
* individual bins and show the frequencies with which observations fall into the
* different bins.

* Our dataset has a variable "totx" which represents the total expenditures of
* households. Creating a histogram for it easy:
histogram totx

* The abbreviated version of "histogram" is "hist":
hist totx

* The histogram will show the entire range and the label of the variable along
* its x-axis. The y-axis is labeled with densities, which are not easy to
* interpret for "normal" earthlings. We recommend switching to percentages or
* frequencies:
histogram totx, percent
histogram totx, frequency

* Later in our course, we'll find that it may be useful to see how "normal"
* a distribution is. Stata allows us to visually inspect this by adding a
* normal distribution to the histogram with the "normal" option:
histogram totx, percent normal

* You can get more documentation on histograms with:
help histogram
* ... and you can customize its appearence (see below!)



** COMPARING QUANTITATIVE DATA BY CATEGORIES (BOX PLOT) -- Box plots are 
* summary graphs that show the distribution of a variable in comparison for
* multiple categories, with indications for the center, central 50% of
* observations, and outliers.

* Our dataset identifies whether a household is located in a rural or urban
* area ("b002"). We can use a boxplot to compare rural and urban household
* expenditures:
graph box totx, over(b002)

* The abbreviated version of "graph box" is "gr box":
gr box totx, over(b002)

* By default, the graph is labeled for each category if the categorical variable
* has value labels, and the range and label of the quantitative variable is
* provided. You can customize the appearance of the graph: see below or read
* the documentation on box plots with:
help graph box



** PLOTTING TWO QUANTITATIVE VARIABLES AGAINST EACH OTHER (SCATTER PLOT) --
* Scatter plots are useful for showing the distribution of two quantitative
* variables in respect to each other.

* Our data contains variables on total household income and expenditures. A
* scatter plot for these two variables is easily created with
graph twoway scatter totx toty

* This command can be abbreviated in many ever-shorter versions:
twoway scatter totx toty
scatter totx toty
tw sc totx toty
sc totx toty
* We like the last one best -- given how frequently we use scatter plots, it's
* fitting to have this command super short.

* By default, the variable listed first will be plotted along the y-axis, and
* variable listed second will be plotted along the x-axis. 

* Especially when you have lots of observations, relatively thick dots for each
* observation may obscure the pattern. You can opt for smaller markers with
sc totx toty, msize(small)

* Not small enough? Go for tiny:
sc totx toty, msize(tiny)

* Stata knows 12 different sizes. You can find a list here:
help markersizestyle

* You can get extensive documentation on scatter plots with:
help scatter

* Scatter plots will come in handy during Econometrics -- we'll be sure to
* revisit this subject...



** CUSTOMIZING AND LABELING YOUR CHARTS --  Stata graphs have sensible default
* options. Usually, the basic command produces a properly labeled, legible
* graph. There are situations where you want or need to fine-tune the settings:
* you may want to adjust the labels to better communicate what the chart shows,
* or you may want to correct default settings in Stata when they don't work well
* for the graph you are producing.

* Often, the most important changes apply to the labeling. We'll start with a
* simple scatter plot:
sc totx toty, msize(tiny)

* and add a title:
sc totx toty, msize(tiny) title("Household Income v Expenditure")

* We can also add subtitles and captions:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009")
* Because graph commands tend to get longer and longer, here's a trick that
* allows us to break the command over several lines to keep for legibility:
* end each line with \\\ until the command is finished. This only works in do-
* files, not in the command line!

* We can also re-label our axes in the graph in case the variable labels don't
* do a perfect job:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009") ///
   xtitle("Total Annual Income") ///
   ytitle("Total Annual Expenditures")
   
* Finally, we may want to change the layout and design of the graph. While it is
* possible to change colors, fonts, and positions manually, Stata has a powerful
* option called "scheme" which allows you to apply a consistent design to the
* entire graph. Two popular options are

* ... graphs that match the design used in The Economist:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009") ///
   xtitle("Total Annual Income") ///
   ytitle("Total Annual Expenditures") ///
   scheme(economist)

* ... and graphs optimized for gray-scale (black and white), low-ink printing:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009") ///
   xtitle("Total Annual Income") ///
   ytitle("Total Annual Expenditures") ///
   scheme(s1mono)
   
* Stata has 11 default schemes and can install more. Find out more at
help schemes

* All of the graphing commands have many options, far more than we want to cover
* here. Be sure to read the extensive documentation that comes with Stata for
* all of the graph commands by calling the help function:
help graph



** SAVING YOUR GRAPHS -- While you are exploring your data set, just looking at
* different graphs is enough. But as you get closer to writing the report, you
* will want to save graphs. The easiest way is to tack a "saving" option onto
* the end of your graph command
sc totx toty, saving(scatter)

* Unfortunately, this produces a graph in Stata's own file format .gph

* If you want to save a graph for inclusion in your written documents, it's best
* to export the graph in a useful file format. This is done with "graph export":
graph export "scatter.pdf"

* This produces a high-quality PDF version of your graph, which is great for 
* inclusion in Word, LaTeX, PowerPoint, ...

* "graph export" can produce other file types (such png, tiff, eps). You can
* find more here:
help graph export




********************************************************************************
**                       IDEAL STRUCTURE OF A DO-FILE                         **
********************************************************************************

* This is an example of the ideal start of a do-file, with comments that explain
* each step and why it is useful to do these steps in the order proposed here.
* Feel free to use this as the template for your own do-files in the future.



************************* BEFORE YOU START WORKING... **************************

** SETTING PAGINATION OF MESSAGES OFF -- When manually running commands, it's
* useful that Stata pauses after a screenful of messages so that you have time
* to read the output before it scrolls past. This is less helpful when running
* do-files that create a lot of output, since it forces to you press a key at
* the end of every screen. Switch it off with:

set more off

* By the way: if you want to make the change permanent, you can use 
set more off, permanently
* Now, you don't need to individually switch more off at the start of each
* session or the top of each do-file. Just remember to switch it back on again
* when you do some manual work in Stata.



** CLOSING ANY RUNNING LOG FILE -- Especially when you do a lot of analysis, you
* may already have a log file open. It is good practice to make sure that you
* properly close running log files when you start a new analysis. The best way
* to do this is to use the following command, which closes any open log files
* and does not complain in case no log was open:
capture log close

* Placing capture before log close is what prevents error messages from stopping
* your work in case there actually was not a log file open.



** CHANGE TO YOUR WORKING DIRECTORY -- It's good practice to have one folder
* contains your data, do files and logs. Before switching on logging, we change
* to this working directory or folder. Once we do this, we don't have to bother
* with directory paths when opening data and logs. Here are examples of how to
* change directories under Windows, Mac and Linux, assuming that your user name
* is StataNinja. (Honestly, why wouldn't you want this to be your user name?)

* Windows:
cd "C:\Users\StataNinja"

* Mac:
cd "/Users/StataNinja"

* Linux:
cd "/home/stataninja/"

* The above examples get you to your user directory. Make sure to change them
* to lead you to your specific data directory.



** SWITCH ON LOGGING -- We recommend switching on logging before you open your
* data file or run any commands. This ensures that you always know what data
* file you were working on and captures any commands you run.

* We also recommend that you have a log file for each session that you run, and
* you label them by day and time when you did your analysis. The advantage of
* this approach is that you can easily find, say, the analysis you did last
* Tuesday afternoon, simply by looking at the name of the log file. Stata can
* automatically open a log file with date and time information:

log using "Log `c(current_date)' `c(current_time)'.log", name("HELPFUL NOTE")

* Feel free to change the name of the log, but make sure to keep the commands
* for date and time -- `c(current_date)' and `c(current_time)' -- in the file
* name.

* We also recommend giving each log file a name, like "HELPFUL NOTE" above.
* You can use this to leave a clue to your future self about what you are doing
* in this log file.

* Finally, if you label your log files with date and time, you usually won't
* need to use the "append" or "replace" options. Unless you open another log
* file in less than 60 seconds, your log file will have a unique name that will
* not repeat again, so there is no risk of having a log file with the same name
* in your working directory.



** OPEN YOUR DATA FILE -- It's best to open your data file right at the start of
* your log. Just like naming your log, opening your data file as the very first
* command helps your future self remember what you are doing.

use "My delightful data.dta", clear

* We recommend using the clear option when opening your data file, but this
* creates the risk of data loss since any data in Stata that has not been saved
* yet will be lost. You do remember our recommendation about backing up your
* original data at least once before and after import, right?



************************* YOUR ANALYSIS HAPPENS HERE! **************************

* At this point, you're good to go. We recommend leaving comments to yourself
* next to each block of commands, and to separate logical units of commands
* from each other with a couple of empty lines. For example, if your first set
* commands import and clean the data, followed by blocks of commands that
* describe and analyze the data, put a couple of empty lines between these
* blocks and leave comments like "import", "data cleaning", "descriptives",
* "analysis", "graphs", etc. at the start of each block.

* Of course, you don't have to be as verbose as we are here. :)




*************************** AT THE END OF YOUR WORK ****************************

** SAVE YOUR DATA AS NEEDED -- Be sure to save your data if you have made
* changes to it that you want to safe-guard. Remember to backup your original
* data at least once before and after import. We recommend that you give sub-
* sequent saves a slightly different file name, like:

save "My delightful data RECODED.dta", replace

* Careful with the "replace" option. If you already have a data file with that
* name, it's contents will be overwritten!

* Make sure you save your data while the log file is still open. In case you
* ever need to figure out where a particular version of a data file comes from,
* you'll have the save command on the log and can scroll up to see how you
* generated the data file.



** FINAL MESSAGES -- Just before you close your log is a good time to leave any
* final notes to yourself, like the time and date when your analysis ended:
display "Analysis ends on `c(current_date)' at `c(current_time)'"

* The abbreviated version of "display" is "di":
di "Analysis ends on `c(current_date)' at `c(current_time)'"



** CLOSE YOUR LOG -- It is best practice to close your log at the end of your
* analysis. This ensures that all your data is written to the hard drive before
* you close Stata. 
log close _all

* Using _all here tells Stata to close any log, independent of the helpful name
* we have given it above.


** CLEAN UP -- We recommend clearing your data at the end of your analysis. This
* is good practice because it establishes that at then end of each orderly
* analysis, no data should be in Stata. If you ever run into a situation where
* data is still in memory when the analysis is over, you can treat it as an
* indicator that something went wrong.


** WE HOPE YOU HAVE A GOOD TIME WORKING IN STATA...




