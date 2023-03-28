import sqlite3

con = sqlite3.connect("tp.db")

cur = con.cursor()

#cur.execute("INSERT INTO Journaliste(nom, prenom) VALUES ('Quentin', 'Filleule')")

#cur.execute("INSERT INTO Journaliste(nom, prenom) VALUES ('Luke', 'Develay')")

#for row in cur.execute("SELECT * FROM Journaliste"):
#    print(row)
#con.commit()

def getNomPrenom(nom, prenom):
    return "nom : " + nom + " prenom : " + prenom

#con.create_function("getnomprenom", 2, getNomPrenom)
#for row in con.execute("SELECT getnomprenom(nom,prenom) FROM Journaliste"):
#    print(row)

def getinfoJourById(id):
    con = sqlite3.connect("tp.db")
    cur = con.cursor() 
    cur.execute("SELECT nom, prenom FROM Journaliste WHERE idJournaliste = ?;", (id,))
    return print(cur.fetchone())

#getinfoJourById(15)
class MySum:
    def __init__(self):
        self.maxi = 0

    def step(self, value):
        if self.maxi < len(value):
            self.maxi = len(value)
        
    def finalize(self):
        return self.maxi

con.create_aggregate("mysum", 1, MySum)
cur.execute("SELECT mysum(nom) FROM Journaliste")
print(cur.fetchone()[0])

#4d
def getnamepluslongJour():
    con = sqlite3.connect("tp.db")
    cur = con.cursor() 
    con.create_aggregate("mysum", 1, MySum)
    cur.execute("SELECT mysum(nom) FROM Journaliste")
    print(cur.fetchone()[0])
getnamepluslongJour()





