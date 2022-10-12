usa sakila;

MOSTRAR ESTADO DEL PROCEDIMIENTO;
MOSTRAR CREAR PROCEDIMIENTO film_in_stock;
LLAME film_in_stock('4', '1', @t);
SELECCIONE @t;

#1
DELIMITADOR $

CREAR FUNCIÓN get_amount(f_id INT, st_id INT) DEVOLUCIONES
INT DETERMINISTA
EMPEZAR
	DECLARAR cant INT;
	SELECCIONE CONTEO (i.inventory_id) EN cant
	DE la película f
	    Inventario de INNER JOIN i USING (film_id)
	    INNER JOIN store st USING (store_id)
	DONDE f.film_id = f_id Y st.store_id = st_id;
	RETORNO (cant); FIN E FIN FIN $
DELIMITADOR ;
SELECCIONE obtener_cantidad(1,1);

#2(no usar ws usar cursor)
DELIMITADOR $

ABANDONAR EL PROCEDIMIENTO SI EXISTE list_procedure $

CREAR PROCEDIMIENTO list_procedure(
	IN co_name VARCHAR(200), OUT list VARCHAR(500))
EMPEZAR
	DECLARE terminado INT DEFAULT 0;
	DECLARE f_name VARCHAR(200) DEFAULT '';
	DECLARE l_name VARCHAR(200) DEFAULT '';
	DECLARAR cuenta VARCHAR(200) POR DEFECTO '';
  DECLARAR cursList CURSOR PARA
	SELECCIONE co.país,c.nombre,c.apellido
	DEL cliente c
	    Dirección de UNIÓN INTERNA USANDO (address_id)
	    UNIÓN INTERNA ciudad USANDO (city_id)
	    INTERNO JOIN país co USING (country_id);
	DECLARAR CONTINUAR MANEJADOR PARA CONJUNTO NO ENCONTRADO terminado = 1;
  ABRIR cursList;

	etiqueta de bucle: BUCLE
		FETCH cursList INTO país, f_name, l_name;
		SI terminó = 1 ENTONCES
		DEJAR looplabel;
		TERMINARA SI;

		IF cuenta = co_nombre THEN SET lista = CONCAT(f_nombre,';',l_nombre);
    TERMINARA SI;
		
		
	etiqueta de bucle FINAL DEL BUCLE;
	CERRAR cursList;
	
FIN $
DELIMITADOR ;

establecer @lista = '';

CALL lista_procedimiento('Argentina',@lista);
SELECCIONE @lista;

SELECCIONE
    CONCAT_WS(';', c.nombre, c.apellido)FROM cliente c
    Anuncio de dirección de INNER JOIN USING (address_id)
    UNIÓN INTERNA city ci USING(city_id)
    INNER JOIN country co USING(country_id) WHERE co.country = 'Argentina';

#- - - - - - - - - - - - - - - - -- -- -- -
DELIMITADOR $
ABANDONAR EL PROCEDIMIENTO SI EXISTE list_procedure $

CREAR PROCEDIMIENTO list_procedure(IN co_name VARCHAR(200))
EMPEZAR
	DECLARAR f_nombre VARCHAR(200);
	DECLARAR l_nombre VARCHAR(200);
	DECLARE terminado BOOLEAN DEFAULT FALSE;
	DECLARAR cursList CURSOR PARA
	SELECCIONE c.nombre, c.apellido
	DEL cliente c
	    Dirección de UNIÓN INTERNA USANDO (address_id)
	    UNIÓN INTERNA ciudad USANDO (city_id)
	    INNER JOIN country co USING(country_id) WHERE co.country = co_name;

DECLARAR CONTINUAR MANEJADOR PARA CONJUNTO NO ENCONTRADO terminado = VERDADERO;
DROP TABLA TEMPORAL SI EXISTE tempTable;
CREAR TABLA TEMPORAL tempTable(first_name VARCHAR(200), last_name VARCHAR(200));


	ABRIR cursList;

	etiqueta de bucle: BUCLE
	FETCH cursList EN f_name, l_name;

	SI terminó = VERDADERO ENTONCES
		DEJAR looplabel;
	TERMINARA SI;

	INSERTAR EN tempTable(first_name,last_name) VALORES (f_name, l_name);

	etiqueta de bucle FINAL DEL BUCLE;	

	CERRAR cursList;

	SELECCIONE CONCAT (nombre, ';', apellido) DE tempTable;
FIN $

LLAMAR list_procedure('Argentina') $
DELIMITADOR ;

#3
SELECCIONE inventario_en_stock(1);  
MOSTRAR CREAR FUNCIÓN inventario_en_stock;
/*
CREAR FUNCIÓN `inventario_en_stock`(p_id_inventario INT) DEVUELVE tinyint(1)
EMPEZAR
    DECLARAR v_rentals INT;
    DECLARAR v_out INT;
    SELECCIONE CONTEO(*) EN v_rentals
    DESDE alquiler
    DONDE inventario_id = p_inventario_id;
    SI v_rentals = 0 ENTONCES DEVUELVA VERDADERO;
    TERMINARA SI;
    SELECCIONE CONTEO (rental_id) EN v_out
    DESDE el inventario IZQUIERDO ÚNETE al alquiler USANDO (inventario_id)
    DONDE inventario.inventario_id = p_inventario_id
    Y rent.return_date ES NULO;
    SI v_out > 0 ENTONCES
      FALSO RETORNO;
    MÁS
      DEVOLVER VERDADERO;
    TERMINARA SI;
FINAL
devuelve 0 o 1 dependiendo de si hay stock de una película o no.
1 representa la disponibilidad de una película y 0 lo contrario.
*/

LLAME a film_in_stock(2,2,@a);
Seleccione un;
MOSTRAR CREAR PROCEDIMIENTO film_in_stock;
/*
CREAR PROCEDIMIENTO `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
EMPEZAR
     SELECCIONE inventario_id
     DEL inventario
     DONDE film_id = p_film_id
     Y store_id = p_store_id
     Y inventario_en_stock(inventario_id);
     SELECCIONE CONTEO(*)
     DEL inventario
     DONDE film_id = p_film_id
     Y store_id = p_store_id
     Y inventario_en_stock(inventario_id)
     EN p_film_count;
FINAL
selecciona los identificadores de inventario de una película en stock, utilizando dos parámetros IN para film_id y store_id.
También cuenta cuántos hay y lo devuelve con un parámetro OUT.
*/
