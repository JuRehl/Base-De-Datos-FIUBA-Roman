-- SET search_path TO pokemon;

-- SELECT * 
-- FROM pokemon p
-- WHERE p.pokename = 'Charizard';

/*EJERCICIO 1*/

-- SELECT p.pokename, p.attack, p.defense
-- FROM pokemon p
-- JOIN pokemoves pm ON p.idpoke=pm.idpoke
-- JOIN moves m ON pm.idmove=m.idmove
-- JOIN categories c ON m.idcat=c.idcat
-- WHERE c.category='Physical' 
-- GROUP BY p.idpoke, p.pokename, p.attack, p.defense
-- HAVING MIN(m.power) >85;

-- Resultados
-- --    pokename   | attack | defense 
-- -- --------------+--------+---------
-- --  Machamp      |    130 |      80
-- --  Nidoking     |    102 |      77
-- --  Dugtrio      |    100 |      50
-- --  Muk          |    105 |      75
-- --  Nidoqueen    |     92 |      87
-- --  Diglett      |     55 |      25
-- --  Graveler     |     95 |     115
-- --  Sandslash    |    100 |     110
-- --  Sandshrew    |     75 |      85
-- -- (9 rows)

/*EJERCICIO 2 */

-- SELECT p.pokename
-- FROM pokemon p
-- JOIN pokemoves pm ON p.idpoke=pm.idpoke
-- JOIN moves m ON pm.idmove=m.idmove
-- JOIN type t ON m.idtype=t.idtype 
-- GROUP BY p.idpoke, p.pokename
-- HAVING
--     SUM(CASE WHEN t.typename='Normal' THEN 1 ELSE 0 END) > 0
--     AND SUM(CASE WHEN t.typename='Flying' THEN 1 ELSE 0 END) > 0
--     AND SUM(CASE WHEN t.typename='Fire' THEN 1 ELSE 0 END) = 0

-- Resultados
--    pokename   
-- --------------
--  Pidgeot     
--  Zapdos      
--  Articuno    
--  Pidgey      
--  Pidgeotto   
-- (5 rows)

/*EJERCICIO 3*/

-- SELECT t.typename, AVG(p.spattack) AS avg_spattack
-- FROM pokemon p
-- JOIN poketype pt ON p.idpoke=pt.idpoke
-- JOIN type t ON pt.idtype=t.idtype
-- GROUP BY t.typename
-- ORDER BY avg_spattack DESC, t.typename ASC
-- LIMIT 5;

-- Resultados
-- --    typename   |     avg_spattack     
-- -- --------------+----------------------
-- --  Dark         | 125.0000000000000000
-- --  Dragon       | 125.0000000000000000
-- --  Ghost        | 115.0000000000000000
-- --  Steel        | 103.3333333333333333
-- --  Electric     |  96.0000000000000000
-- -- (5 rows)

/*EJERCICIO 4*/

-- SELECT p.idpoke, p.pokename, p.speed
-- FROM pokemon p 
-- JOIN pokemoves pm ON p.idpoke=pm.idpoke
-- JOIN moves m ON pm.idmove=m.idmove
-- GROUP BY p.idpoke, p.pokename, p.speed
-- HAVING 
--     SUM(m.power) > 250
--     AND AVG(m.accuracy) >=95;

-- Resultados
--  idpoke |   pokename   | speed 
-- --------+--------------+-------
--      18 | Pidgeot      |   101
--     145 | Zapdos       |   100
--       8 | Wartortle    |    58
--     146 | Moltres      |    90
--       6 | Charizard    |   100
--       9 | Blastoise    |    78
--      25 | Pikachu      |    90
--      17 | Pidgeotto    |    71
-- (8 rows)

/*EJERCICIO 5*/

-- SELECT p.pokename, p.defense
-- FROM pokemon p 
-- JOIN poketype pt ON p.idpoke=pt.idpoke
-- JOIN type t ON pt.idtype=t.idtype
-- WHERE t.typename='Ground'
--     AND p.defense= (
--         SELECT MIN(p2.defense)
--         FROM pokemon p2
--         JOIN poketype pt2 ON p2.idpoke=pt2.idpoke
--         JOIN type t2 ON pt2.idtype=t2.idtype
--         WHERE t2.typename='Ground'
--     );

-- -- Resultados
-- --    pokename   | defense 
-- -- --------------+---------
-- --  Diglett      |      25
-- -- (1 row)


/*EJERCICIO 6*/

-- SELECT p.pokename
-- FROM pokemon p
-- JOIN pokemoves pm ON p.idpoke=pm.idpoke
-- JOIN moves m ON pm.idmove=m.idmove
-- JOIN categories c ON m.idcat=c.idcat
-- GROUP BY p.pokename
-- HAVING COUNT(DISTINCT c.idcat)= (SELECT COUNT(*) FROM categories); 

-- -- Resultados
-- --    pokename   
-- -- --------------
-- --  Charmander  
-- --  Gastly      
-- --  Gengar      
-- --  Haunter     
-- --  Venusaur    
-- -- (5 rows)