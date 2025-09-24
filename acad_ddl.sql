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
	total_credit INT CHECK (total_credit > 0),
	departement_id VARCHAR(4) NOT NULL,
	
	CONSTRAINT fk_departement FOREIGN KEY (departement_id) REFERENCES acad.Departement(code)
);

-- Table Bloc
CREATE TABLE acad.Bloc (
	bloc_id VARCHAR(3) PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	min_credit INT NOT NULL CHECK (min_credit >= 0),
	max_credit INT NOT NULL CHECK (min_credit <= max_credit),
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
	id VARCHAR(3) PRIMARY KEY,
	nom VARCHAR(100) NOT NULL,
	saison_code VARCHAR(10) NOT NULL,
	
	CONSTRAINT fk_trimestre_saison FOREIGN KEY (saison_code) REFERENCES acad.Saison(code)
);

-- Table Cours
CREATE TABLE acad.Cours (
	code VARCHAR(8) PRIMARY KEY,
	nom VARCHAR(50) NOT NULL,
	credit INT DEFAULT 3 CHECK (credit > 0),
	trimestre_id VARCHAR(3),
	
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

-- Insertions saisons
INSERT INTO acad.Saison (code) VALUES
('Automne'), ('Hiver'), ('Été');

-- Insertions départements
INSERT INTO acad.Departement (code, nom, faculte) VALUES
('INFO', 'Informatique', 'Arts et Sciences'),
('MATH', 'Mathématiques', 'Arts et Sciences'),
('DESN', 'Design', 'Aménagement');

-- Insertions programmes
INSERT INTO acad.Programme (code, nom, total_credit, departement_id) VALUES
('117510', 'Baccalauréat en informatique', 90, 'INFO'),
('119040', 'Mineure en mathématiques', 30, 'MATH');

-- Insertions blocs
INSERT INTO acad.Bloc (bloc_id, nom, min_credit, max_credit, programme_id) VALUES
('B01', 'Bloc Fondamentaux', 0, 12, '117510'),
('B02', 'Bloc Avancé', 6, 15, '117510');

-- Insertions orientations
INSERT INTO acad.Orientation (nom, programme_id) VALUES
('IA', '117510'),
('Réseaux', '117510');

-- Insertions trimestres
INSERT INTO acad.Trimestre (id, nom, saison_code) VALUES
('A25', 'Automne 2025', 'Automne'),
('E25', 'Été 2025', 'Été'),
('H25', 'Hiver 2025', 'Hiver');

-- Insertions cours
INSERT INTO acad.Cours (code, nom, credit, trimestre_id) VALUES
('IFT1015', 'Introduction à la programmation', 3, 'A25'),
('IFT1005', 'Design web', 3, 'A25');

-- Insertions cours_saison
INSERT INTO acad.Cours_Saison (cours_id, saison_code) VALUES
('IFT1015', 'Automne'),
('IFT1015', 'Hiver'),
('IFT1015', 'Été'),
('IFT1005', 'Automne'),
('IFT1005', 'Hiver');

-- Insertions groupes
INSERT INTO acad.Groupe (bloc_id, cours_id) VALUES
('B01', 'IFT1015'),
('B01', 'IFT1005');
