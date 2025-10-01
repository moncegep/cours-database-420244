-- Créer le schéma si besoin
CREATE SCHEMA IF NOT EXISTS pokemon;

-- Supprimer les tables existantes en respectant les dépendances
DROP TABLE IF EXISTS pokemon.joueurs CASCADE;
DROP TABLE IF EXISTS pokemon.equipes CASCADE;

-- Table: equipes
CREATE TABLE pokemon.equipes (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE,
    couleur TEXT,
    date_creation DATE NOT NULL,
    chef_id INT,
    CONSTRAINT chk_date_creation CHECK (date_creation <= CURRENT_DATE)
    -- La FK vers joueurs sera ajoutée après la création de joueurs
);

-- Table: joueurs
CREATE TABLE pokemon.joueurs (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pseudo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE,
    equipe_id INT,
    niveau INT NOT NULL CHECK (niveau BETWEEN 1 AND 100),
    points_experience INT NOT NULL CHECK (points_experience >= 0),
    statut TEXT NOT NULL CHECK (statut IN ('actif', 'inactif', 'banni')),
    CONSTRAINT fk_joueur_equipe FOREIGN KEY (equipe_id) REFERENCES pokemon.equipes(id) ON DELETE SET NULL,
    CONSTRAINT uq_pseudo_equipe UNIQUE (pseudo, equipe_id)
);

-- Ajouter la FK de chef_id vers joueurs.id maintenant que joueurs existe
ALTER TABLE pokemon.equipes
ADD CONSTRAINT fk_chef FOREIGN KEY (chef_id) REFERENCES pokemon.joueurs(id) ON DELETE SET NULL;

-- Index partiel pour la recherche rapide des joueurs actifs
CREATE INDEX idx_joueurs_actifs ON pokemon.joueurs(pseudo)
WHERE statut = 'actif';

-- Index sur niveau + points_experience pour optimiser les tris et filtres
CREATE INDEX idx_joueurs_niveau_experience ON pokemon.joueurs(niveau, points_experience);
