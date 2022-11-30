#docker build -t "korah91/rethinkdbscript:latest" .
#docker push "korah91/rethinkdbscript:latest"

docker build -t "korah91/nginx" -f Dockerfile.nginx --no-cache .
docker push korah91/nginx
./reiniciarTodo.sh