UTILIZAR sakila;

/* 1 Escriba una consulta que obtenga todos los clientes que viven en Argentina.
Muestra el nombre y apellido en una columna, la dirección y la ciudad.
 */

SELECCIONE
    CONCAT( c . nombre , '  ' , c . apellido ) AS  ' Nombre ' ,
    anuncio _ dirección ,
    ci . ciudad
DEL cliente c
    ALMACENAMIENTO DE UNIÓN INTERNA USING (store_id)
    INNER JOIN address ad ON  sto . address_id  =  anuncio . dirección_id
    UNIÓN INTERNA city ci USING(city_id)
    INNER JOIN país co USING (country_id)
DONDE  co . pais  =  ' Argentina ' ;

SELECCIONE
    CONCAT( c . nombre , '  ' , c . apellido ) AS  ' Nombre ' ,
    anuncio _ dirección  ci . ciudad
DEL cliente c
    Anuncio de dirección de INNER JOIN USING (address_id)
    UNIÓN INTERNA city ci USING(city_id)
    INNER JOIN país co USING (country_id)
DONDE  co . pais  =  ' Argentina ' ;

/* 2 Escriba una consulta que muestre el título de la película, el idioma y la clasificación.
La calificación se mostrará como el texto completo descrito aquí */

SELECCIONE
    F. _ titulo ,
    yo _ nombre ,
    F. _ calificación ,
    CASO
        CUANDO F. _ calificación  LIKE  ' G ' THEN ' Todas las edades admitidas '
        CUANDO F. _ calificación  LIKE  ' PG ' THEN ' Algunos materiales pueden no ser adecuados para niños '
        CUANDO F. _ calificación  COMO  ' PG-13 ' ENTONCES ' Algunos materiales pueden ser inapropiados para niños menores de 13 años'
        CUANDO F. _ calificación  COMO  ' R ' ENTONCES ' Menor de 17 años requiere un padre o tutor adulto que lo acompañe '
        CUANDO F. _ calificación  COMO  ' NC-17 ' ENTONCES ' No se admiten menores de 17 años'
    FIN ' Texto de calificación '
DE la película f
    UNIÓN INTERNA idioma l USING(idioma_id);

/* 3 Escriba una consulta de búsqueda que muestre todas las películas (título y año de estreno) de las que formó parte un actor.
Supongamos que el actor proviene de un cuadro de texto introducido a mano desde una página web.
Asegúrese de "ajustar" el texto de entrada para intentar encontrar las películas con la mayor eficacia posible.
 */

SELECCIONE
    CA _ actor_id ,
    CONCAT(
        CA _ primer_nombre ,
        '  ' ,
        CA _ apellido
    ),
    F. _ film_id ,
    F. _ título
DE la película f
    INNER JOIN film_actor USING(film_id)
    UNIÓN INTERNA actor ac USING(actor_id)
DÓNDE
    CONCAT(first_name, '  ' , last_name) LIKE  TRIM ( UPPER ( ' PENELOPE GUINESS ' ));

/* 4Encuentra todos los alquileres realizados en los meses de mayo y junio.
Muestre el título de la película, el nombre del cliente y si se devolvió o no.
Debe haber una columna devuelta con dos valores posibles 'Sí' y 'No'.
 */

SELECCIONE
    F. _ titulo ,
    r _ fecha_de_alquiler ,
    do . primer_nombre ,
    CASO
        CUANDO r . return_date  NO ES NULO ENTONCES ' Sí '
        ELSE ' No '
    FIN ' Devuelto '
DESDE alquiler r
    Inventario de INNER JOIN i USING (inventario_id)
    INNER JOIN película f USING (film_id)
    INNER JOIN cliente c USING (customer_id)
DÓNDE
    MES( r . fecha_alquiler ) =  ' 05 '
    O MES( r . fecha_alquiler ) =  ' 06 '
ORDEN POR  r . fecha_alquiler ;
