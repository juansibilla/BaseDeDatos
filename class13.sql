UTILIZAR sakila;

#Añadir un nuevo cliente
#Para almacenar 1
#Para la dirección use una dirección existente. El que tiene el address_id más grande en 'Estados Unidos'
INSERTAR EN
    cliente (
        store_id,
        primer nombre,
        apellido,
        Email,
        dirección_id,
        activo
        )
SELECCIONE
    1,
    'juan',
    'juansi',
    'juansibilla@gmail.com',
    MAX(anuncio.dirección_id),
    1
DE anuncio de dirección
DONDE ad.city_id EN (
SELECCIONE ci.city_id
DESDE país co, ciudad ci
WHERE co.país = "Estados Unidos"
Y co.id_país = ci.id_país
Y ci.city_id = ad.city_id
    );

SELECT * FROM cliente WHERE last_name = "Pairone";

#Añadir un alquiler
#Facilita la selección de cualquier título de película. Es decir, debería poder poner 'mosaico de película' en el lugar, y no en la identificación.
#No verifique si la película ya está alquilada, solo use cualquiera del inventario, por ejemplo, la que tenga la identificación más alta.
#Seleccione cualquier staff_id de la Tienda 2.
INSERTAR EN
    alquiler (
        fecha_de_alquiler,
        id_de_inventario,
        Identificación del cliente,
        Fecha de regreso,
        Identificación del personal
    )
SELECCIONE CURRENT_TIMESTAMP, (
SELECCIONE MAX(i.inventory_id) DESDE el inventario i
INNER JOIN película f USING (film_id)
DONDE f.título COMO 'ACE GOLDFINGER'
    ),
    600,
    NULO, (
        SELECCIONE manager_staff_id
        DE la tienda
        DONDE store_id = 2
        ORDENAR AL AZAR()
        LÍMITE 1
    );

SELECCIONE * DESDE alquiler DONDE customer_id = 600;

#Actualizar el año de la película según la calificación
#Por ejemplo, si la clasificación es 'G', la fecha de lanzamiento será '2001'
#Puedes elegir el mapeo entre calificación y año.
#Escriba cuantas sentencias sean necesarias.
SELECCIONA calificación DISTINTA
DE la película;

ACTUALIZAR película SET lanzamiento_año = 2000 DONDE calificación = 'PG';
ACTUALIZAR película SET lanzamiento_año = 2001 DONDE calificación = 'G';
ACTUALIZAR película SET lanzamiento_año = 2002 DONDE calificación = 'NC-17';
ACTUALIZAR película SET release_year = 2003 WHERE rating ='PG-13';
ACTUALIZAR película SET lanzamiento_año = 2004 DONDE calificación = 'R';
SELECCIONE * DE la película DONDE calificación = 'PG';

#Devolver una película
#Escribe las declaraciones y consultas necesarias para los siguientes pasos.
#Encuentra una película que aún no haya sido devuelta. Y usa esa identificación de alquiler. Elija el último que se alquiló, por ejemplo.
#Use la identificación para devolver la película.
SELECCIONE r.rental_id
DE la película f
    Inventario de INNER JOIN i USING (film_id)
    ALQUILER DE UNIÓN INTERNA r USING (inventario_id)
DONDE r.return_date ES NULO
ORDENAR POR r.rental_date DESC
LÍMITE 1;

ACTUALIZAR alquiler
SET return_date = CURRENT_TIMESTAMP
DONDE alquiler_id = 16050;

#Intentar eliminar una película
#Compruebe lo que sucede, describa qué hacer.
#Escriba todas las declaraciones de eliminación necesarias para eliminar completamente la película de la base de datos.
SELECCIONE *
DE la película
ORDENAR POR film_id DESC LÍMITE 1;

ELIMINAR DE película DONDE título = 'ZORRO ARCA';

#Resultado
#No se puede eliminar o actualizar una fila principal: falla una restricción de clave externa (`sakila`.`film_actor`,
#RESTRICCIÓN `fk_film_actor_film` CLAVE EXTERNA (`film_id`) REFERENCIAS `film` (`film_id`)
#ON ACTUALIZAR CASCADA)
#La solucion para esto es borrar primero(en orden de hijo a padre) las filas a las que la pelicula esta relacionada.
#Tambien se puede desactivar FOREIGN KEY CHECK y luego volver a activarlo, pero esto no es recomendable
ELIMINAR DEL pago
DONDE id_alquiler EN ( SELECCIONE id_alquiler DESDE alquiler
USO DE INVENTARIO DE UNIÓN INTERNA (inventario_id)
DONDE film_id = 1000
    );

ELIMINAR DEL alquiler
DONDE inventario_id EN (
SELECCIONE id_inventario DEL inventario
DONDE film_id = 1000
    );

ELIMINAR DEL inventario DONDE film_id = 1000;
ELIMINAR DESDE film_actor DONDE film_id = 1000;
ELIMINAR DESDE film_category DONDE film_id = 1000;
ELIMINAR DE película DONDE título = 'ZORRO ARCA';

#6
SELECCIONE inventario_id, film_id
DEL inventario
DONDE Inventory_id NO EN (
SELECCIONE id_inventario DEL inventario
Alquiler de INNER JOIN USANDO (inventory_id)
DONDE return_date ES NULO
    );


SELECCIONE *
DESDE el inventario i IZQUIERDO UNIRSE al alquiler r USING (inventario_id)
DONDE r.return_date ES NULL;

#inventario_id 1 film_id 1
INSERTAR EN
    alquiler (
        fecha_de_alquiler,
        id_de_inventario,
        Identificación del cliente,
        Fecha de regreso,
        Identificación del personal
    )
VALORES(
        MARCA DE TIEMPO_ACTUAL, 10, (
            SELECCIONE
                Identificación del cliente
            Del cliente
            ORDENAR AL AZAR()
            LÍMITE 1
        ), NULO, (
            SELECCIONE id_personal
            DEL personal
            DONDE store_id EN(
                    SELECCIONE
                        store_id
                    DE
                        inventario
                    DÓNDE
                        inventario_id = 1
                )
        )
    );

INSERTAR EN
    pago (
        Identificación del cliente,
        Identificación del personal,
        alquiler_id,
        Monto,
        fecha de pago
    )
VALORES( (#id_cliente
            SELECCIONE
                Identificación del cliente
            DESDE alquiler r
            ORDENAR POR
                fecha_alquiler DESC
            LÍMITE 1
        ), (#Identificación del personal
            SELECCIONE id_personal
            DESDE alquiler r
            ORDENAR POR
                fecha_alquiler DESC
            LÍMITE 1
        ), (#alquiler_id
            SELECCIONE rent_id
            DESDE alquiler r
            ORDENAR POR
                fecha_alquiler DESC
            LÍMITE 1
        ), 10, CURRENT_TIMESTAMP
    );

SELECCIONE * DESDE pago ORDEN POR fecha_pago DESC LIMIT 1;
