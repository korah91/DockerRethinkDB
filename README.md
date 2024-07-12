# DockerRethinkDB
This small project demonstrates the deployment of a RethinkDB database and an NGINX server using Docker-Compose and Kubernetes. It showcases the setup and orchestration of containers for a scalable and reliable real-time database solution. This project was completed during my third year of engineering studies (two years ago). 🎓

I enjoyed working on this project as it involved learning about Kubernetes and Docker and connecting systems, which was very hard at first, but it was very rewarding.

## Table of Contents

- [Docker-Compose Setup](#docker-compose-setup)
- [Kubernetes Setup](#kubernetes-setup)
  - [Deployments](#deployments)
  - [Ingress](#ingress)
  - [Namespaces](#namespaces)
  - [Kubernetes Diagram](#kubernetes-diagram)

## Docker-Compose Setup

To run the project using Docker-Compose, navigate to the `Archivos Docker` directory and execute:
  
    docker-compose up

This command will start the RethinkDB container followed by a script container. The script creates a collection in RethinkDB, inserts documents, and reads them. The setup ensures that the same documents are not re-inserted upon each execution by deleting and recreating the collection.

- The RethinkDB image used is the official one, while the script's image, created from an Alpine base with Python and the RethinkDB library installed, is hosted on my Docker Hub: korah91/rethinkdbscript-docker.

## Kubernetes Setup

The Kubernetes setup replicates the Docker-Compose functionalities with additional features from Kubernetes.  The cluster consists of three deployments, two Cluster-IP services, a persistent volume claim, and an Ingress object.

### Deployments

There are three deployments:

- RethinkDB: The main database.
- Script: Executes database operations.
- NGINX: Serves as a proxy to access the RethinkDB web interface.

The script's deployment image, similar to the Docker-Compose version, communicates with RethinkDB to perform database operations. The NGINX server verifies the functionality of the persistent volume by accessing it through its shell.

### Ingress
The Ingress object facilitates access to the NGINX server and the RethinkDB interface via defined routes.

### Namespaces
Namespaces are used to logically separate the cluster, preventing conflicts between development and production environments. The inicializarTodo.sh script prompts for a namespace name, creating Kubernetes objects within the specified namespace.

### Kubernetes Diagram
Below is a visual representation of the Kubernetes cluster setup.

![Kubernetes Diagram](https://github.com/korah91/DockerRethinkDB/blob/main/diagrama%20kubernetes.jpg)
