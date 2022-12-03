# Este script inicializa todos los servicios, deployments y volumenes
# Se asume que minikube esta instalado y en marcha con el driver para ingress

echo "Iniciando el cluster"

kubectl delete deployment server-rethinkdb 
kubectl delete deployment script 
kubectl delete deployment nginx 
kubectl delete pvc volumen-reclamacion 
kubectl delete service c-nginx
kubectl delete service c-rethinkdb
kubectl delete ingress my-ingress 

# ---------------- SERVICIOS ---------------- #
# ClusterIP para que script cree las tablas en servidor-rethinkdb
kubectl apply -f c-rethinkdb.yml
kubectl apply -f c-nginx.yml
kubectl apply -f ingress.yml
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


# Se consigue la ip de minikube para acceder
ip=`minikube ip`
echo "Se accede a nginx en ${ip}"