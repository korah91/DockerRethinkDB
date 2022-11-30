kubectl delete deployment server-rethinkdb
kubectl delete deployment script
kubectl delete deployment nginx
kubectl delete pvc volumen-reclamacion


kubectl apply -f volumen-reclamacion.yml 
kubectl apply -f deployment-rethinkdb.yml
kubectl apply -f deployment-script.yml
kubectl apply -f deployment-nginx.yml