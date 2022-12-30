FROM ubuntu:23.04

RUN apt-get update
RUN apt-get install nginx -y

COPY index.html /var/www/html
ADD index.tar /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

