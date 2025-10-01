-- 1. Liste des départements pour une faculté donnée (ex: 'Arts et Sciences')
SELECT code, nom                        
FROM acad.Departement                   
WHERE faculte = 'Arts et Sciences';     

-- 2. Liste des programmes pour un département donné (ex: 'INFO')
SELECT code, nom
FROM acad.Programme
WHERE departement_id = 'INFO';

-- 3. Liste des programmes pour un département donné (ex: 'INFO'), incluant les orientations associées
SELECT
    p.code AS programme_code,
    p.nom AS programme_nom,
    o.orientation_id,
    o.nom AS orientation_nom
FROM acad.Programme p
LEFT JOIN acad.Orientation o ON o.programme_id = p.code
WHERE p.departement_id = 'INFO';

-- 4. Liste des blocs pour un programme donné (ex: 117510)
SELECT bloc_id, nom, min_credit, max_credit
FROM acad.Bloc
WHERE programme_id = '117510';

-- 5. Liste des cours pour un programme donné (ex: 117510)
SELECT DISTINCT c.code, c.nom, c.credit
FROM acad.Cours c
JOIN acad.Groupe g ON g.cours_id = c.code
JOIN acad.Bloc b ON b.bloc_id = g.bloc_id
WHERE b.programme_id = '117510';

-- 6. Liste des cours pour un trimestre donné (ex: A25)
SELECT code, nom, credit
FROM acad.Cours
WHERE trimestre_id = 'A25';

-- 7. Liste des cours pour les trimestres d'une saison donnée (ex: Automne)
SELECT c.code, c.nom, c.credit
FROM acad.Cours c
JOIN acad.Trimestre t ON c.trimestre_id = t.id
WHERE t.saison_code = 'Automne';