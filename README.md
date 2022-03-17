# Haproxy load balancer for Nginx redirect to wordpress app  using Docker and Ansible  

Creates HAProxy load balancer for  Nginx web server  using Docker  and Ansibe  The script will create and configure 4 docker contaire, one load balancer, and one Nginx web server that redirect to wordpress container this last one linked to mariadb. HAProxy will act as a load balancer for the Nginx web server. All of the 4 servers will be containerized using Dockerfile and Docker-Compose with ansible docker compose  playbook we can manage the docker compose file .

# Overview of the project:
![N|Solid]( https://user-images.githubusercontent.com/39303616/158866581-e13530bd-6f25-4c9b-b920-50d815f7aa26.png)


# Prerequisites:
 - Docker.
 - Docker Compose.
 - Pulling the following images form Docker Hub:
   Nginx 
   HAProxy 
   Wordpress 
   MariaDB


# Technical details:
 - Docker network subnet is: 10.0.2.0/27
 - HAProxy load balancer IP address is: 10.0.2.21
 - Nginx web server 1 IP address: 10.0.2.17
 - Wordpress  webapp IP address: 10.0.2.27
 - MariaDB database IP address: 10.0.2.17
 - Exposed port for Nginx and HAProxy is: 80
 - The env  file for the  variables that used in docker-compose 



# Installation steps:
 - Clone the repo
 - Run the script (as sudo) from the main script �script.sh� file:

```sh
cd Nextmedia-proxy-nginx-ansbile
chmod a+x script.sh
./script.sh
```
 - The script will install docker and docker-compose, then execute the docker-compose which will build and start the three servers.
 - Test the load balancer by executing some random curl commands on the HAProxy IP to check the response from both web servers

 ```sh
curl 10.0.2.21
```

 - Benchmark the web servers by sending a punch of requests directly:

 ```sh
ab -n 3000 -c 20 http:// 10.0.2.21/
```
