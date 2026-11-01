-- PROYECTO 4: SQL
-- Base de datos: Bookings
-- Motor: PostgreSQL 17

-- EJERCICIO 1
-- Mostrar los vuelos cuyo estado sea On Time y sus identificadores

SELECT
    flight_id,
    status
FROM bookings.flights
WHERE status = 'On Time';

-- EJERCICIO 2
-- Reservas superiores a 1.000.000 de rublos
SELECT *
FROM bookings.bookings
WHERE total_amount > 1000000;

-- EJERCICIO 3
-- Mostrar todos los datos de los aviones
SELECT *
FROM bookings.airplanes_data;

-- EJERCICIO 4
-- Vuelos realizados con Boeing 737
SELECT flight_id, route_no
FROM bookings.flights
WHERE route_no IN (
    SELECT route_no
    FROM bookings.routes
    WHERE airplane_code = '733'
);

-- EJERCICIO 5
-- Información de billetes de pasajeros llamados Irina
SELECT *
FROM bookings.tickets
WHERE passenger_name ILIKE '%Irina%';

-- EJERCICIO 6
-- Ciudades con más de un aeropuerto
SELECT
    city->>'en' AS ciudad,
    COUNT(*) AS numero_aeropuertos
FROM bookings.airports_data
GROUP BY city->>'en'
HAVING COUNT(*) > 1
ORDER BY numero_aeropuertos DESC;

-- EJERCICIO 7
-- Número de vuelos por modelo de avión
SELECT
    a.model->>'en' AS modelo_avion,
    COUNT(f.flight_id) AS numero_vuelos
FROM bookings.airplanes_data a
LEFT JOIN bookings.routes r
    ON a.airplane_code = r.airplane_code
LEFT JOIN bookings.flights f
    ON r.route_no = f.route_no
GROUP BY a.airplane_code, a.model
ORDER BY numero_vuelos DESC;

-- EJERCICIO 8
-- Reservas con varios billetes
SELECT
    book_ref,
    COUNT(*) AS numero_billetes
FROM bookings.tickets
GROUP BY book_ref
HAVING COUNT(*) > 1
ORDER BY numero_billetes DESC;

-- EJERCICIO 9
-- Vuelos con retraso superior a una hora
SELECT
    flight_id,
    route_no,
    scheduled_departure,
    actual_departure,
    actual_departure - scheduled_departure AS retraso
FROM bookings.flights
WHERE actual_departure > scheduled_departure + INTERVAL '1 hour'
ORDER BY retraso DESC;