-- Créer le schéma s'il n'existe pas encore
CREATE SCHEMA IF NOT EXISTS cegep;

-- Supprimer les tables si elles existent (ordre inverse des dépendances)
DROP TABLE IF EXISTS cegep.Inscription CASCADE;
DROP TABLE IF EXISTS cegep.EvenementOrganisateur CASCADE;
DROP TABLE IF EXISTS cegep.Organisateur CASCADE;
DROP TABLE IF EXISTS cegep.Utilisateur CASCADE;
DROP TABLE IF EXISTS cegep.Evenement CASCADE;
DROP TABLE IF EXISTS cegep.TypeEvenement CASCADE;
DROP TABLE IF EXISTS cegep.Etablissement CASCADE;

-- Créer les tables
CREATE TABLE cegep.Etablissement (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    sigle VARCHAR(50),
    ville VARCHAR(100) NOT NULL
);


CREATE TABLE cegep.TypeEvenement (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);


CREATE TABLE cegep.Evenement (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    type_id INT,
    lieu TEXT NOT NULL,
    ville VARCHAR(100),
    debut TIMESTAMP NOT NULL,
    fin TIMESTAMP NOT NULL,
    capacite INT NOT NULL,
    CONSTRAINT type_fk FOREIGN KEY (type_id) REFERENCES cegep.TypeEvenement (id) ON DELETE SET NULL
);


CREATE TABLE cegep.Organisateur (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    prenom VARCHAR(100) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    etablissement_id INT,
    CONSTRAINT fk_etablissement FOREIGN KEY (etablissement_id) REFERENCES cegep.Etablissement (id) ON DELETE SET NULL
);


CREATE TABLE cegep.EvenementOrganisateur (
    evenement_id INT,
    organisateur_id INT,
    evenement_role TEXT,
    PRIMARY KEY (evenement_id, organisateur_id),
    CONSTRAINT fk_event FOREIGN KEY (evenement_id) REFERENCES cegep.Evenement (id) ON DELETE CASCADE,
    CONSTRAINT fk_organisateur FOREIGN KEY (organisateur_id) REFERENCES cegep.Organisateur (id) ON DELETE CASCADE
);


CREATE TABLE cegep.Utilisateur (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    prenom VARCHAR(100) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    courriel TEXT UNIQUE
);


CREATE TABLE cegep.Inscription (
    utilisateur_id INT,
    evenement_id INT,
    confirme BOOLEAN,
    annule BOOLEAN,
    present TIMESTAMP,
    CONSTRAINT pk_inscription PRIMARY KEY (utilisateur_id, evenement_id),
    CONSTRAINT fk_utilisateur FOREIGN KEY (utilisateur_id) REFERENCES cegep.Utilisateur (id) ON DELETE CASCADE,
    CONSTRAINT fk_evenement FOREIGN KEY (evenement_id) REFERENCES cegep.Evenement (id) ON DELETE CASCADE
);
