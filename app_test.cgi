#!/usr/bin/python3
from wsgiref.handlers import CGIHandler
from flask import Flask, url_for
from flask import render_template, request, redirect
import psycopg2
import psycopg2.extras
## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist199082" 
DB_DATABASE=DB_USER
DB_PASSWORD="Noobreality1"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)
app = Flask(__name__)
'''a) Inserir e remover categorias e sub-categorias;
b) Inserir e remover um retalhista, com todos os seus produtos, garantindo que esta operação seja
atómica;
c) Listar todos os eventos de reposição de uma IVM, apresentando o número de unidades repostas por
categoria de produto;
d) Listar todas as sub-categorias de uma super-categoria, a todos os níveis de profundidade.'''

@app.route('/')
def home():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        return render_template("home.html", cursor=cursor)
    except Exception as e:
        str(e)

@app.route('/categorias')
def list_categories():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT nome FROM categoria;"
        cursor.execute(query)
        return render_template("categories.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route('/delete_category', methods = ["POST"])
def eliminar_categoria():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        nome=request.form["nome_categoria"]
        query = 'DELETE FROM categoria WHERE nome = %s'
        data=(nome,)
        cursor.execute(query,data)
        return redirect(url_for('list_categories'))
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route('/adicionar')
def add_categoria():
    try:
        return render_template("add_categoria.html")
    except Exception as e:
        return str(e)

@app.route('/insert', methods=["POST"])
def inserir_categoria():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        categoria_add=request.form["nome_categoria"]
        query = 'INSERT INTO categoria VALUES (%s);'
        data=(categoria_add,)
        cursor.execute(query,data)
        return redirect(url_for('list_categories'))
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()



@app.route('/IVMs', methods=['POST'])
def list_ivms():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = 'SELECT * FROM ivm'
        cursor.execute(query)
        return render_template("ivms.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route('/ivm/evento_reposicao', methods=['POST'])
def list_evento_reposicao():
    dbConn=None
    cursor=None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        n_serie=request.form["num_serie"]
        fabricante=request.form["fabricante"]
        query = 'SELECT SUM(unidades) FROM evento_reposicao er INNER JOIN produto p ON er.ean = p.ean GROUP BY p.cat HAVING num_serie = n_serie'
        data=(n_serie, fabricante)
        cursor.execute(query, data)
        return render_template("eventos_reposicao.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()


CGIHandler().run(app)