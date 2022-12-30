# Docker ITI

## Lab1

### Problem1

![plot](./images/Screenshot%20from%202022-12-28%2013-14-58.png)


```bash
$ sudo docker run hello-world
$ sudo docker ps -a
$ sudo docker start 64d459f955b3
$ sudo docker rm 64d459f955b3
$ sudo docker images
$ sduo docker rmi feb5d9fea6a5
```


### Problem2

![plot](images/Screenshot%20from%202022-12-28%2013-16-04.png)


```bash
$ sudo docker run -it ubuntu
$ echo docker
$ touch hello-docker
$ sudo docker stop d3917c73d21d
$ sudo docker rm d3917c73d21d
```
\# all files deleted once I removed the container

```bash
$ sudo docker container prune
```


### Problem3

![plot](./images/Screenshot%20from%202022-12-28%2013-16-32.png)


```bash
$ sudo docker volume create vol
$ sudo docker run -it -v vol:/usr/share/nginx/html -p 8085:80 --name nginxCon5 nginx bash
$ cd /usr/share/nginx/html/
$ echo "Remon Louis" >> index.html 
$ service start nginx
$ sudo docker stop faa
$ sudo docker rm faa
$ sudo docker run -it -v vol:/usr/share/nginx/html -p 8088:80 --name nginxCon6 nginx bash
$ service start nginx
```

### Problem4

![plot](./images/Screenshot%20from%202022-12-28%2013-16-58.png)


```bash
$ sudo docker run -it -p 8090:80 --name nginxCon8 nginx bash
$ cd /usr/share/nginx/html/
$ toch RemonLouis.html
$ echo "Remon Louis" >> RemonLouis.html 
$ sudo docker images
$ sudo docker commit ed579e1e3144 testimage:version1.0
```
```Dockerfile
FROM nginx
CMD [ "Remon Louis" ]
```
```bash
# Docker file created
$ sudo docker build -t remonlouis_image .
```
### Problem5

![plot](./images/Screenshot%20from%202022-12-28%2013-17-31.png)

```Bash
$ sudo docker run --name app-database9 -v mysql_data:/var/lib/mysql -p 3040:3306 -e MYSQL_ROOT_PASSWORD=P4sSw0rd0! -d mysql
```
---
---

## Lab2

![plot](./images/Screenshot%20from%202022-12-29%2014-57-31.png)

### P1


```Bash
#created html page and change add dummy paragraph with name index.html
#Make tar file of index.html
$ tar -cvf index.tar index.html

```


```Dockerfile
FROM ubuntu:23.04

RUN apt-get update
RUN apt-get install nginx -y

COPY index.html /var/www/html
ADD index.tar /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

```

```Bash
$ sudo docker build -t mynginx:v1.0 .
$ sudo docker run -d -p 9091:80 mynginx:v1.0
```

### P2

1. part1-SingleStage

\# install node local on my machine and then create the react app

```Bash
$ sudo apt install nodejs
$ sudo apt install npm
$ sudo npm i -g npx
$ sudo npx create-react-app my-app
```
\# ---- I ignored react project node-modules file
\# create Dockerfile

```Dockerfile
# use a light image of node
FROM node:alpine3.16

# make directory (app) and cd the dir
WORKDIR /app

# copy src files to the Dist
COPY my-app/package*.json ./

# install packages
RUN npm install

# copy source code to the dist
COPY my-app/ .

# Port 3000
EXPOSE 3000

# start app
CMD [ "npm" , "start" ]

```
\# bulid the image from this Dockerfile

```Bash
$ sudo docker build -t remon-app:v1.0 .
```
\# run a container from this generated image


```Bash
$ sudo docker run -it --name remon-app -p 3009:3000 remon-app:v1.0
```
\# check localhost:3009 and it is up and running


2. part2-MultiStage


```Dockerfile
# use a light image of node
FROM node:alpine3.16 AS builderstage

# make directory (app) and cd the dir
WORKDIR /app

# copy src files to the Dist
COPY my-app/package*.json ./

# install packages
RUN npm install

# copy source code to the dist
COPY my-app/ .

# Port 3000
EXPOSE 3000

# start app
RUN npm run build


# use the nginx Base Image
FROM nginx:alpine

# copy the bulid result from the builderstage
COPY --from=builderstage /app/build /usr/share/nginx/html


# prot 80 for nginx
EXPOSE 80

# run nginx
CMD [ "nginx" , "-g" , "daemon off;" ]

```

```Bash
$ sudo docker build -t my-app:v2.0 .
$ sudo docker run -it --name remon-multistage-app -p 6070:80 my-app:v2.0
```

\# check localhost:6070 and it is up and running


### P3

1. bridge :
   The default network driver. If you don’t specify a driver, this is the type of network you are creating.
2. host :
   For standalone containers, remove network isolation between the container and the Docker host, and use the host’s networking directly
3. overlay :
   Overlay networks connect multiple Docker daemons together and enable swarm services to communicate with each other. You can also use overlay networks to facilitate communication between a swarm service and a standalone container, or between two standalone containers on different Docker daemons.
4. ipvlan :
   IPvlan networks give users total control over both IPv4 and IPv6 addressing. The VLAN driver builds on top of that in giving operators complete control of layer 2 VLAN tagging and even IPvlan L3 routing for users interested in underlay network integration. 
5. macvlan:
   Macvlan networks allow you to assign a MAC address to a container, making it appear as a physical device on your network. The Docker daemon routes traffic to containers by their MAC addresses. Using the macvlan driver is sometimes the best choice when dealing with legacy applications that expect to be directly connected to the physical network, rather than routed through the Docker host’s network stack.
6. none:
   or this container, disable all networking. Usually used in conjunction with a custom network driver. none is not available for swarm services.
7. Network blugins :
   You can install and use third-party network plugins with Docker. These plugins are available from Docker Hub or from third-party vendors.

### p4


```bash
# create a bridge network
$ sudo docker network create my-net

# create 2 containers and attatch them to bridge network I created
$ sudo docker run -d --name con1 --network my-net nginx
$ sudo docker run -d --name con2 --network my-net nginx

# inspect the network to make sure that the 2 containers are already attached to it

$ sudo docker network inspect my-net

# open first container to install ping package
$ sudo docker container exec -it con1 bash
$ apt-get update
$ apt-get install inetutils-ping

# back to my local machine and try to ping second container from the first one
$ sudo docker exec -ti con1 ping con2

```