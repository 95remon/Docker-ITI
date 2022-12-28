# Docker ITI

## Lab1

### Problem1

![plot](./Day1/Screenshot%20from%202022-12-28%2013-14-58.png)


```bash
$ sudo docker run hello-world
$ sudo docker ps -a
$ sudo docker start 64d459f955b3
$ sudo docker rm 64d459f955b3
$ sudo docker images
$ sduo docker rmi feb5d9fea6a5
```


### Problem2

![plot](Day1/Screenshot%20from%202022-12-28%2013-16-04.png)


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