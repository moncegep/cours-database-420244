-- =========================================================
-- Création du schéma
-- =========================================================
DROP SCHEMA IF EXISTS bistro CASCADE;
CREATE SCHEMA bistro;

-- =========================================================
-- Tables
-- =========================================================

-- Table categorie
CREATE TABLE bistro.categorie (
    categorie_id INTEGER GENERATED ALWAYS AS IDENTITY,
    nom          VARCHAR(50) NOT NULL UNIQUE,
    description  TEXT,
    CONSTRAINT pk_categorie PRIMARY KEY (categorie_id)
);

-- Table ingredient
CREATE TABLE bistro.ingredient (
    ingredient_id    INTEGER GENERATED ALWAYS AS IDENTITY,
    nom              VARCHAR(50) NOT NULL UNIQUE,
    calories         INTEGER,
    contient_gluten  BOOLEAN NOT NULL DEFAULT FALSE,
    contient_noix    BOOLEAN NOT NULL DEFAULT FALSE,
    contient_lait    BOOLEAN NOT NULL DEFAULT FALSE,
    fournisseur      TEXT,
    CONSTRAINT pk_ingredient PRIMARY KEY (ingredient_id),
    CONSTRAINT ck_ingredient_calories CHECK (calories >= 0)
);

-- Table plat
CREATE TABLE bistro.plat (
    plat_id       INTEGER GENERATED ALWAYS AS IDENTITY,
    nom           VARCHAR(100) NOT NULL UNIQUE,
    prix          NUMERIC(6,2) NOT NULL,
    calories      INTEGER,
    vegetarien    BOOLEAN NOT NULL DEFAULT FALSE,
    sans_gluten   BOOLEAN NOT NULL DEFAULT FALSE,
    categorie_id  INTEGER NOT NULL,
    photo_url     TEXT,
    CONSTRAINT pk_plat PRIMARY KEY (plat_id),
    CONSTRAINT fk_plat_categorie FOREIGN KEY (categorie_id) REFERENCES bistro.categorie(categorie_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ck_plat_prix CHECK (prix >= 0),
    CONSTRAINT ck_plat_calories CHECK (calories >= 0)
);

-- Table menu
CREATE TABLE bistro.menu (
    menu_id    INTEGER GENERATED ALWAYS AS IDENTITY,
    date_menu  DATE NOT NULL,
    service    VARCHAR(20) NOT NULL,
    theme      VARCHAR(100),
    publie     BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_menu PRIMARY KEY (menu_id),
    CONSTRAINT ck_menu_service CHECK (service IN ('midi','soir'))
);

-- Table plat_ingredient (association n-n)
CREATE TABLE bistro.plat_ingredient (
    plat_id        INTEGER NOT NULL,
    ingredient_id  INTEGER NOT NULL,
    CONSTRAINT pk_plat_ingredient PRIMARY KEY (plat_id, ingredient_id),
    CONSTRAINT fk_pi_plat FOREIGN KEY (plat_id) REFERENCES bistro.plat(plat_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_pi_ingredient FOREIGN KEY (ingredient_id) REFERENCES bistro.ingredient(ingredient_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Table menu_plat (association n-n + rôle)
CREATE TABLE bistro.menu_plat (
    menu_id  INTEGER NOT NULL,
    plat_id  INTEGER NOT NULL,
    role     VARCHAR(20) NOT NULL,
    CONSTRAINT pk_menu_plat PRIMARY KEY (menu_id, plat_id),
    CONSTRAINT fk_mp_menu FOREIGN KEY (menu_id) REFERENCES bistro.menu(menu_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_mp_plat FOREIGN KEY (plat_id) REFERENCES bistro.plat(plat_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ck_menu_plat_role CHECK (role IN ('principal','accompagnement','dessert','boisson'))
);
