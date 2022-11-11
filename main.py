import time
from rethinkdb import RethinkDB
r = RethinkDB()

print("Conectandose a rethinkdb...")

try:
	r.connect( "localhost", 28015).repl()
except:
	print("No se ha podido conectar")
	quit()
print("Conexion satisfactoria")
time.sleep(1)

# Por defecto se crea una database test. Ahora creamos la tabla authors
try:
	r.db("test").table_create("authors").run()
except:
	print("No se ha podido crear la tabla, posiblemente ya este creada")
	r.db('test').table_drop("authors").run()
	print("Se ha borrado la tabla, en la siguiente ejecucion se deberia poder crear")
	quit()

print("Se ha creado la tabla authors en la database test")
time.sleep(1)
# Ahora insertamos tres documentos. No hace falta referirse a la database test porque esta por defecto
r.table("authors").insert([
    { "name": "William Adama", "tv_show": "Battlestar Galactica",
      "posts": [
        {"title": "Decommissioning speech", "content": "The Cylon War is long over..."},
        {"title": "We are at war", "content": "Moments ago, this ship received..."},
        {"title": "The new Earth", "content": "The discoveries of the past few days..."}
      ]
    },
    { "name": "Laura Roslin", "tv_show": "Battlestar Galactica",
      "posts": [
        {"title": "The oath of office", "content": "I, Laura Roslin, ..."},
        {"title": "They look like us", "content": "The Cylons have the ability..."}
      ]
    },
    { "name": "Jean-Luc Picard", "tv_show": "Star Trek TNG",
      "posts": [
        {"title": "Civil rights", "content": "There are some words I've known since..."}
      ]
    }]).run()

print("Se han anadido 3 objetos JSON a la tabla authors")
time.sleep(0.5)
print("Ahora se imprimiran los objetos guardados...")
for obj in r.table("authors").run():
	time.sleep(0.4)
	print(obj)
