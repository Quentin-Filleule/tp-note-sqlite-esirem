import sqlite3

con = sqlite3.connect("tp.db")
cur = con.cursor()

#cc = cur.execute("SELECT * FROM Journaliste")

def strNom(id):

	for row in con.execute("SELECT strNom(?)",("id",)):

	prenom = cur.execute("SELECT j.prenom FROM Journaliste j WHERE i_journaliste=? ,(id,)")
	nom = cur.execute("SELECT j.nom FROM Journaliste j WHERE i_journaliste=?, (id,)")
	affiche = prenom +" " + nom
	return	affiche	

con.create_function("afficheNom", 1, strNom)

id =10 

res = con.execute("SELECT afficheNom(?)",(id,)):
res.fetchall()




