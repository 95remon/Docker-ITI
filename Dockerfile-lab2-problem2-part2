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

