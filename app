from flask import Flask, render_template, request
from db import DatabaseManager
app = Flask(__name__)

@app.route("/")
def home():
    return render_template('index.html')

@app.route("/allinfo")
def allinfo():
    return render_template('allinfo.html')

@app.route("/form")
def form():
    return render_template('form.html')

@app.route("/read_form", methods=['POST'])
def read_form():
    hist = DatabaseManager('histori.db')
    hist.query("""CREATE TABLE IF NOT EXISTS Histori(
	"id"	INTEGER UNIQUE,
	"name"	text,
	"imlink"	text,
	"linkya"	text,
	"descrip"	text,
	"excurs"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);""")
    data=request.form
    name=data['name']
    imlink = data['imlink']
    linkya = data['linkya']
    descrip = data['descrip']
    excurs = data['excurs']
    datadic=(name, imlink, linkya, descrip, excurs)
    # userEmail = data['userEmail']
    # userNmae = data['name']
    # userLastname = data['lastname']
    # dictsend = (userEmail, userNmae, userLastname)
    hist.query('''INSERT INTO Histori(name, imlink, linkya, descrip, excurs) VALUES (?,?,?,?,?)''',datadic)
    return render_template('read_form.html')

if __name__=="__main__":
    app.run(debug=True)




