-- =========================================================
-- Données d'exemple
-- =========================================================

-- categorie
INSERT INTO bistro.categorie (nom, description) VALUES
 ('Entree','Petits plats de début de repas'),
 ('Plat principal','Plat principal du service'),
 ('Accompagnement','Complément du plat'),
 ('Dessert','Fin de repas sucré'),
 ('Boisson','Boissons froides ou chaudes'),
 ('Salade','Plats froids à base de légumes'),
 ('Soupe','Plats liquides/chauds'),
 ('Sandwich','Plats entre deux pains'),
 ('Pates','Plats à base de pâtes'),
 ('Poisson','Plats à base de poisson');

-- ingredient
INSERT INTO bistro.ingredient (nom, calories, contient_gluten, contient_noix, contient_lait, fournisseur) VALUES
 ('Farine', 364, TRUE,  FALSE, FALSE, 'Fournisseur A'),
 ('Lait',    60, FALSE, FALSE, TRUE,  'Fournisseur B'),
 ('Pommes',  52, FALSE, FALSE, FALSE, 'Vergers X'),
 ('Oeufs',   72, FALSE, FALSE, FALSE, 'Ferme Lune'),
 ('Beurre', 717, FALSE, FALSE, TRUE,  'Laiterie C'),
 ('Sucre',  387, FALSE, FALSE, FALSE, 'Sucrerie D'),
 ('Poulet', 239, FALSE, FALSE, FALSE, 'Boucherie E'),
 ('Riz',    130, FALSE, FALSE, FALSE, 'Céréales F'),
 ('Tomates', 18, FALSE, FALSE, FALSE, 'Maraîcher G'),
 ('Amandes', 579, FALSE, TRUE,  FALSE, 'Noiseraie H');

-- plat
-- On suppose les categorie_id comme suit (par insertion) : 1:entree 2:plat_principal etc.
INSERT INTO bistro.plat (nom, prix, calories, vegetarien, sans_gluten, categorie_id, photo_url) VALUES
 ('Salade verte',        7.50, 150, TRUE,  TRUE,  6, NULL),
 ('Tarte aux pommes',    3.50, 380, TRUE,  FALSE, 4, NULL),
 ('Poulet grille',      11.90, 420, FALSE, TRUE,  2, NULL),
 ('Soupe tomate',        4.90, 120, TRUE,  TRUE,  7, NULL),
 ('Sandwich dinde',      8.90, 430, FALSE, FALSE, 8, NULL),
 ('Curry legumes',      10.50, 520, TRUE,  TRUE,  2, NULL),
 ('Riz saute',           6.90, 320, TRUE,  TRUE,  3, NULL),
 ('Saumon grille',      13.90, 450, FALSE, TRUE, 10, NULL),
 ('Brownie',             2.90, 410, TRUE,  FALSE, 4, NULL),
 ('Smoothie fruit',      4.50, 180, TRUE,  TRUE,  5, NULL);

-- menu
INSERT INTO bistro.menu (date_menu, service, theme, publie) VALUES
 ('2025-09-26','midi','Menu santé', TRUE),
 ('2025-09-26','soir','Menu comfort', FALSE),
 ('2025-09-27','midi','Fraîcheur', TRUE),
 ('2025-09-27','soir','Protéiné', FALSE),
 ('2025-09-28','midi','Végétarien', TRUE),
 ('2025-09-28','soir','Maison', FALSE),
 ('2025-09-29','midi','Classiques', TRUE),
 ('2025-09-29','soir','Océan', FALSE),
 ('2025-09-30','midi','Tout Tomate', TRUE),
 ('2025-09-30','soir','Douceurs', FALSE);

-- plat_ingredient
INSERT INTO bistro.plat_ingredient (plat_id, ingredient_id) VALUES
 (1,9),   -- salade_verte : tomates
 (1,3),   -- + pommes (option sucrée)
 (2,1),   -- tarte : farine
 (2,2),   -- tarte : lait
 (2,3),   -- tarte : pommes
 (2,4),   -- tarte : oeufs
 (2,5),   -- tarte : beurre
 (2,6),   -- tarte : sucre
 (3,7),   -- poulet_grille : poulet
 (4,9),   -- soupe_tomate : tomates
 (5,1),   -- sandwich_dinde : farine (pain)
 (6,9),   -- curry_legumes : tomates
 (7,8),   -- riz_saute : riz
 (8,10),  -- saumon_grille : amandes concassées (topping)
 (9,1),   -- brownie : farine
 (9,2),   -- brownie : lait
 (9,4),   -- brownie : oeufs
 (9,5),   -- brownie : beurre
 (9,6),   -- brownie : sucre
 (10,3);  -- smoothie_fruit : pommes (base)

-- menu_plat
-- Roles autorisés: 'principal','accompagnement','dessert','boisson'
INSERT INTO bistro.menu_plat (menu_id, plat_id, role) VALUES
 (1,3,'principal'), (1,7,'accompagnement'), (1,10,'boisson'),
 (2,8,'principal'), (2,4,'accompagnement'), (2,9,'dessert'),
 (3,6,'principal'), (3,1,'accompagnement'), (3,10,'boisson'),
 (4,3,'principal'), (4,5,'accompagnement'), (4,2,'dessert'),
 (5,6,'principal'), (5,4,'accompagnement'), (5,1,'accompagnement'),
 (6,8,'principal'), (6,7,'accompagnement'), (6,9,'dessert'),
 (7,5,'principal'), (7,7,'accompagnement'), (7,2,'dessert'),
 (8,8,'principal'), (8,1,'accompagnement'), (8,10,'boisson'),
 (9,4,'principal'), (9,7,'accompagnement'), (9,1,'accompagnement'),
 (10,3,'principal'), (10,9,'dessert'), (10,10,'boisson');