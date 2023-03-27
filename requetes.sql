/*--------------------------------------------------------------------------------*/
/*Partie Création de la base de données*/
/*--------------------------------------------------------------------------------*/


/*Activation des clefs étrangères*/
PRAGMA foreign_keys=ON;

/*Destruction des tables si elles existent*/
DROP TABLE IF EXISTS Correspondance;
DROP TABLE IF EXISTS  Article;
DROP TABLE IF EXISTS Journaliste;

/*Création des différentes Tables*/
CREATE TABLE Journaliste
(
	i_journaliste INT PRIMARY KEY,
	prenom VARCHAR(100),
	nom VARCHAR(100)
	
);



CREATE TABLE Article
(
	i_article INT PRIMARY KEY,
	title VARCHAR(100),
	category VARCHAR(100)
	
);


CREATE TABLE Correspondance
(
	id_A INT,
	id_J INT,
	FOREIGN KEY (id_J) REFERENCES Journaliste (i_journaliste) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (id_A) REFERENCES Article (i_article) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(id_J,id_A)

	
);

/*Remplissage des tables*/

.mode csv
.import journalistes.csv Journaliste  
.import articles.csv Article 
.import correspondance.csv Correspondance


/*--------------------------------------------------------------------------------*/
/*Partie Manipulation de la base de données*/
/*-------------------------------------------------------------------------------*/



/*Afficher le nombre d'articles écrit par chaque journaliste
SELECT Journaliste.prenom, Journaliste.nom, COUNT(Correspondance.id_A)
FROM Journaliste,Correspondance
WHERE Journaliste.i_journaliste = Correspondance.id_J
GROUP BY Journaliste.i_journaliste;
*/



/*Pareil en affichant dabord celui qui a le plus d'articles
SELECT Journaliste.prenom, Journaliste.nom, COUNT(Correspondance.id_A)
FROM Journaliste,Correspondance
WHERE Journaliste.i_journaliste = Correspondance.id_J
GROUP BY Journaliste.i_journaliste
ORDER BY COUNT(Correspondance.id_A) DESC;
*/



/*Afficher le nb d'article dans la rubrique tech écrit par chaque journaliste
SELECT Journaliste.prenom, Journaliste.nom, COUNT(Correspondance.id_A)
FROM Journaliste,Correspondance,Article
WHERE Journaliste.i_journaliste = Correspondance.id_J AND Article.category = "tech"
AND Article.i_article = Correspondance.id_A
GROUP BY Journaliste.i_journaliste;*/



/*Supprimer les articles tech du journaliste 10
DELETE FROM Article
WHERE Article.category = "tech" AND Article.i_article IN (SELECT Correspondance.id_A FROM Correspondance WHERE Correspondance.id_J = 10);*/



/* Afficher les infos des journalistes avec 30 articles ou plus
SELECT Journaliste.prenom, Journaliste.nom, COUNT(Correspondance.id_A) as nb
FROM Journaliste,Correspondance,Article
WHERE Journaliste.i_journaliste = Correspondance.id_J AND Article.category = "tech"
AND Article.i_article = Correspondance.id_A
GROUP BY Journaliste.i_journaliste
HAVING COUNT(Article.i_article) > 30;*/



/*le nb d'articles/journalistes et par category
SELECT Article.category, Journaliste.prenom, Journaliste.nom, COUNT(Correspondance.id_A)
FROM Journaliste,Correspondance,Article
WHERE Journaliste.i_journaliste = Correspondance.id_J
AND Article.i_article = Correspondance.id_A
GROUP BY Article.category,Journaliste.i_journaliste;*/


/*4 AJOUT DE FONCTIONALITES EN SQLITE
DROP View IF EXISTS articles_tech;
CREATE View articles_tech (id,title)
AS
SELECT Article.i_article,Article.title
FROM Article
WHERE Article.category = "tech";


SELECT * FROM articles_tech LIMIT 10;*/

/*---2.1---
SELECT Correspondance.id_J
FROM Correspondance
WHERE Correspondance.id_A IN (SELECT Article.i_article  FROM Article WHERE Article.category = "tech");
*/

/*---2.2---
SELECT Correspondance.id_J
FROM Correspondance
WHERE Correspondance.id_A IN (SELECT id  FROM articles_tech);
*/


/*---2.3---
SELECT Correspondance.id_J
FROM Correspondance
INNER JOIN articles_tech ON
id = Correspondance.id_A;
*/

/*---4.3.1---*/

DROP TABLE IF EXISTS nb_articles_par_rubrique;
CREATE TABLE nb_articles_par_rubrique AS
	SELECT Article.category AS category,COUNT(Article.i_article) AS nb_article
	FROM Article
	GROUP BY Article.category;


SELECT * FROM nb_articles_par_rubrique;



/*CREATE TRIGGER addArticle AFTER INSERT ON Article
BEGIN 
	UPDATE nb_articles_par_rubrique
	SET nb_article = nb_article +1
	WHERE new.category = category;
END;*/

/*INSERT INTO Article (title,category) VALUES ("bonjour","tech");

SELECT * FROM nb_articles_par_rubrique;*/


/*CREATE TRIGGER supArticle AFTER DELETE ON Article
BEGIN 
	UPDATE nb_articles_par_rubrique
	SET nb_article = nb_article -1
	WHERE old.category = category;
END;

DELETE FROM Article
WHERE Article.category = "tech" AND Article.i_article IN (SELECT Correspondance.id_A FROM Correspondance WHERE Correspondance.id_J = 10);

SELECT * FROM nb_articles_par_rubrique;*/



/*CREATE TRIGGER supArticle AFTER UPDATE ON Article
BEGIN 
	UPDATE nb_articles_par_rubrique
	SET nb_article = nb_article -1
	WHERE old.category = category;

	UPDATE nb_articles_par_rubrique
	SET nb_article = nb_article +1
	WHERE new.category = category;
END;*/


/*---5.1---*/

/*Dans le fichier python*/







