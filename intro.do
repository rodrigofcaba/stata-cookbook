********************************************************************************
**                   USO BÁSICO DE LA LÍNEA DE COMANDOS                       **
********************************************************************************

* Para el propósito de la introducción a este cookbook, utilizamos un solo comando:
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