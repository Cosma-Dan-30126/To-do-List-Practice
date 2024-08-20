#Using an official version of Node.JS runtime as a parent image
FROM node:lts-alpine

RUN npm install -g http-server
#Installing a simple http server for serving static content

#Setting the working directory
WORKDIR /app

COPY  package*.json ./

#Installing dependencies
RUN npm install 

COPY . .

#Building the Vue part of the app

RUN npm run build

# Exposing port 8080 
EXPOSE 8080

#Comand to run the app

CMD ["npm", "run", "build"]
