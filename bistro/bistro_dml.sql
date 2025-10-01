-- Q1

SELECT nom, prix
FROM bistro.Plat;

-- Q2

SELECT nom
FROM bistro.Plat
WHERE vegetarien = TRUE;

-- Q3

SELECT *
FROM bistro.Menu
WHERE date_menu = '2025-09-26';

-- Q4

SELECT nom
FROM bistro.Ingredient
WHERE contient_gluten = TRUE;

-- Q5

SELECT mp.role, p.nom AS plat, c.nom AS categorie, p.prix
FROM bistro.menu m
JOIN bistro.menu_plat mp ON m.menu_id = mp.menu_id
JOIN bistro.plat p ON mp.plat_id = p.plat_id
JOIN bistro.categorie c ON p.categorie_id = c.categorie_id
WHERE m.date_menu = '2025-09-26' AND m.service = 'midi';

-- Q6

SELECT i.nom, i.contient_gluten, i.contient_noix, i.contient_lait
FROM bistro.plat p
JOIN bistro.plat_ingredient pi ON p.plat_id = pi.plat_id
JOIN bistro.ingredient i ON pi.ingredient_id = i.ingredient_id
WHERE p.nom = 'Tarte aux pommes'

-- Q7

SELECT p.nom AS plat, c.nom AS categorie
FROM bistro.ingredient i
JOIN bistro.plat_ingredient pi ON i.ingredient_id = pi.ingredient_id
JOIN bistro.plat p ON pi.plat_id = p.plat_id
JOIN bistro.categorie c ON p.categorie_id = c.categorie_id
WHERE i.nom = 'Lait';
