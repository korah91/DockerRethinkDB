# Este script inicializa todos los servicios, deployments y volumenes

kubectl delete deployment server-rethinkdb
kubectl delete deployment script
kubectl delete deployment nginx
kubectl delete pvc volumen-reclamacion

# ---------------- SERVICIOS ---------------- #
# Servicio para acceder por IPTUNNELMINIKUBE:8080 a la interfaz grafica de rethinkDB
kubectl apply -f service-rethinkdb.yml
# Servicio para acceder por IPTUNNELMINIKUBE:80 a NGINX y ver los contenidos del volumen persistente
kubectl apply -f service-nginx.yml
# ClusterIP para que script cree las tablas en servidor-rethinkdb
kubectl apply -f c-rethinkdb.yml

# ---------------- VOLUMEN ---------------- #
# Creacion de reclamacion de volumen
kubectl apply -f volumen-reclamacion.yml

# ---------------- DEPLOYMENTS ---------------- #
# Creacion de deployment de la base de datos rethinkDB 
kubectl apply -f deployment-rethinkdb.yml
# Creacion de deployment de container cliente
kubectl apply -f deployment-script.yml
# Creacion de deployment de servidor nginx que muestra el contenido del volumen.
kubectl apply -f deployment-nginx.yml

# ---------------- TUNNEL ---------------- #
#
minikube tunnel