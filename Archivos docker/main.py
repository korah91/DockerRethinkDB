import time
import os
from rethinkdb import RethinkDB
r = RethinkDB()

print("Conectandose a rethinkdb...")

# Se inicia la conexion a la base de datos con direccion el ClusterIP, que redirige la peticion a un pod
try:
  r.connect( "c-rethinkdb", 28015).repl()
  print("Conexion satisfactoria")
except Exception as e:
  print("No se ha podido conectar")
  print(e)
  quit()


seHaCreado = True
# Si no se ha creado la coleccion se crea
# Por defecto se crea una database test. Ahora creamos la tabla authors
try:
  r.db("test").table_create("authors").run()
  print("Se ha creado la tabla authors en la database test")
  time.sleep(1)
except Exception as e:
  print("No se ha podido crear la tabla porque ya se ha creado antes")
  seHaCreado = False
  #print(e)

# Si se acaba de crear la coleccion se anaden los documentos, si no, no.
# Ahora insertamos tres documentos. No hace falta referirse a la database test porque esta por defecto
if seHaCreado == True:
  try:
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
    print("Ahora el script se acaba y cuando se vuelva a ejecutar solo leera los documentos guardados en el volumen")
    quit()
    
  except Exception as e:
    print(f"No se han podido insertar los documentos")
    print(e)
else:
  print("Como ya existe la tabla, no vuelvo a insertar los documentos")


# Se imprimen los documentos
nElementos = 0
print(f"-------------------------\nAhora se imprimiran los objetos guardados. \n-------------------------")
for obj in r.table("authors").run():
  nElementos += 1
  time.sleep(0.4)
  print(obj)
print(f"Hay un total de {nElementos} elementos ")





# Espero un minuto
#time.sleep(60)



