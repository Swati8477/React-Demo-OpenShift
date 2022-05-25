# FROM node:current-alpine
# WORKDIR /app

# ENV PATH /app/node_modules/.bin:$PATH

# COPY package*.json ./app
# RUN npm install

# EXPOSE 8080

# COPY . .
# CMD ["npm","start"]

# Step 1

# FROM node:10-alpine as build-step

# RUN mkdir /app

# WORKDIR /app

# COPY package.json /app

# RUN npm install

# COPY . /app

# RUN npm run build

# # Stage 2
# FROM nginx:1.17.1-alpine
# COPY --from=build-step /app/build /usr/share/nginx/html

# #base of node alpine - light image
# FROM node:alpine
# #create a folder in docker
# WORKDIR '/app'

# #copy package.json in same root folder
# COPY package.json .
# #install the packages
# RUN npm install
# #copy all the content in docker file
# COPY . .
# #run the application
# CMD [ "npm", "start" ]






# FROM node:10 AS builder

# WORKDIR /app

# COPY . .

# RUN npm install
# RUN npm run build


# FROM nginx:alpine

# WORKDIR /usr/share/nginx/html

# COPY --from=builder /app/build /usr/share/nginx/html

# CMD ["nginx","-g","daemon off;"]





# get the base node image
FROM node:alpine as builder

# set the working dir for container
WORKDIR /frontend

# copy the json file first
COPY ./package.json /frontend

# install npm dependencies
RUN npm install

# copy other project files
COPY . .

# build the folder
RUN npm run build

# Handle Nginx
FROM nginx
COPY --from=builder /frontend/build /var/cache/nginx/client_temp
# COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf