# use a light image of node
FROM node:alpine3.16

WORKDIR /app

# copy src files to the Dist
COPY react-app/package*.json ./

# install packages
RUN npm install

# copy source code to the dist
COPY react-app/ .

# start app
CMD [ "npm","start" ]
