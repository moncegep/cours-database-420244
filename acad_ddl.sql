CREATE SCHEMA IF NOT EXISTS acad;

-- Suppression des tables dans l'ordre des dépendances
DROP TABLE IF EXISTS acad.Groupe CASCADE;
DROP TABLE IF EXISTS acad.Cours_Saison CASCADE;
DROP TABLE IF EXISTS acad.Cours CASCADE;
DROP TABLE IF EXISTS acad.Trimestre CASCADE;
DROP TABLE IF EXISTS acad.Orientation CASCADE;
DROP TABLE IF EXISTS acad.Bloc CASCADE;
DROP TABLE IF EXISTS acad.Programme CASCADE;
DROP TABLE IF EXISTS acad.Departement CASCADE;
DROP TABLE IF EXISTS acad.Saison CASCADE;

-- Table Saison (ex: 'Automne', 'Hiver', 'Été')
CREATE TABLE acad.Saison (
    code VARCHAR(10) PRIMARY KEY
);

-- Table Département
CREATE TABLE acad.Departement (
	code VARCHAR(4) PRIMARY KEY,
	nom VARCHAR(100) NOT NULL,
	faculte VARCHAR(100) NOT NULL
);

-- Table Programme
CREATE TABLE acad.Programme (
	code VARCHAR(6) PRIMARY KEY,
	nom VARCHAR(100) NOT NULL,
	description TEXT NOT NULL,
	total_credit INT CHECK (total_credit > 0),
	departement_id VARCHAR(4) NOT NULL,
	
	CONSTRAINT fk_departement FOREIGN KEY (departement_id) REFERENCES acad.Departement(code)
);

-- Table Bloc
CREATE TABLE acad.Bloc (
	bloc_id VARCHAR(3) PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	min_credit INT CHECK (min_credit >= 0),
	max_credit INT CHECK (min_credit <= max_credit),
	programme_id VARCHAR(6) NOT NULL,
	
	CONSTRAINT fk_bloc_programme FOREIGN KEY (programme_id) REFERENCES acad.Programme(code)
);

-- Table Orientation
CREATE TABLE acad.Orientation (
	orientation_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	programme_id VARCHAR(6) NOT NULL,
	
	CONSTRAINT fk_programme FOREIGN KEY (programme_id) REFERENCES acad.Programme(code)
);

-- Table Trimestre
CREATE TABLE acad.Trimestre (
	id INT PRIMARY KEY,
	nom VARCHAR(100) NOT NULL,
	saison_code VARCHAR(10) NOT NULL,
	
	CONSTRAINT fk_trimestre_saison FOREIGN KEY (saison_code) REFERENCES acad.Saison(code)
);

-- Table Cours
CREATE TABLE acad.Cours (
	code VARCHAR(8) PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	credit INT DEFAULT 3 CHECK (credit > 0),
	trimestre_id INT,
	
	CONSTRAINT fk_trimestre FOREIGN KEY(trimestre_id) REFERENCES acad.Trimestre(id)
);

-- Table Cours_Saison (association Cours ↔ Saison)
CREATE TABLE acad.Cours_Saison (
    cours_id VARCHAR(8),
    saison_code VARCHAR(10),
	
    CONSTRAINT pk_cours_saison PRIMARY KEY (cours_id, saison_code),
    CONSTRAINT fk_cours FOREIGN KEY (cours_id) REFERENCES acad.Cours(code),
    CONSTRAINT fk_saison FOREIGN KEY (saison_code) REFERENCES acad.Saison(code)
);

-- Table Groupe (association Bloc ↔ Cours)
CREATE TABLE acad.Groupe (
	bloc_id VARCHAR(3),
	cours_id VARCHAR(8),
	
	CONSTRAINT pk_groupe PRIMARY KEY (bloc_id, cours_id),
	CONSTRAINT fk_bloc FOREIGN KEY(bloc_id) REFERENCES acad.Bloc (bloc_id),
	CONSTRAINT fk_cours FOREIGN KEY(cours_id) REFERENCES acad.Cours (code)
);
