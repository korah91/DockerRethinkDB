# Este script inicializa todos los servicios, deployments y volumenes
# Se asume que minikube esta instalado y en marcha con el driver para ingress: minikube addons enable ingress

echo "Iniciando el cluster"

# Un Namespace es un cluster virtual dentro del cluster fisico
# Para desarrollo es buena idea utilizar un Namespace dev para desarrollo y prod para produccion
echo "Elige el namespace a utilizar."
read -p "Escribe dev o prod => " namesp

# Se crea el namespace
kubectl create namespace $namesp
# Se configura el namespace que va a utilizar kubectl para sus instrucciones
kubectl config set-context --current --namespace=$namesp
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


echo -e "Es normal que de errores de tipo not found\n"

echo "El volumen persistente lo utiliza rethinkdb y nginx."
podnginx=`kubectl get pods | grep nginx | cut -d ' ' -f1`
echo -e "Ejecutando el comando 'kubectl exec -it ${podnginx} sh' y navegando a /usr/share/nginx/html/rethinkdb se encuentra el volumen montado con los datos de rethinkdb\n"

# Se consigue la ip de minikube para acceder
ip=`minikube ip`
echo -e "Se accede a nginx en ${ip}\n"