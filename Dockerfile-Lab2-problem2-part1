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
