# 420-244-AH — Base de données applicatives  

Ce dépôt (répertoire) contient les scripts SQL utilisés et produits dans le cadre du cours **420-244-AH — Base de données applicatives**.  
Il est organisé par projet ou thème d’apprentissage.


## 📁 Structure du projet

| Répertoire    | Description |
|---------------|-------------|
| `acad/`       | Base de données pour la gestion académique (étudiants, cours, etc.) |
| `bistro/`     | Base de données pour la gestion de menus d'une cafétéria |
| `intercegep/` | Schéma d’un système d'organisation d'évènements inter-cégep |
| `librairie/`  | Schéma d’une base de données de bibliothèque |
| `pokemon/`    | Base de données simplifiée inspirée du jeu Pokémon |

---

## 📜 Types de scripts

- `DDL` : instructions de création (CREATE TABLE, etc.)
- `DML` : instructions de manipulation des données (SELECT, UPDATE, DELETE...)
- `SEED` : jeu de données d’exemple (INSERT INTO...)

---

## ▶️ Exécution des scripts

1. Assurez-vous d’avoir PostgreSQL installé et accessible.
2. Connectez-vous à la base de données cible (ex. avec `psql` ou PgAdmin).
3. Exécutez les scripts dans l’ordre suivant :
   - DDL (structure)
   - SEED (exemples de données)
   - DML (requêtes d’analyse ou de manipulation)

---

## 📄 Licence

Ce contenu est fourni dans un but pédagogique dans le cadre du cours 420-244-AH.  
Reproduction autorisée à des fins éducatives.
