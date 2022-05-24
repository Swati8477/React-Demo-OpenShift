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

#base of node alpine - light image
FROM node:alpine
#create a folder in docker
WORKDIR '/app'

#copy package.json in same root folder
COPY package.json .
#install the packages
RUN npm install
#copy all the content in docker file
COPY . .
#run the application
CMD [ "npm", "start" ]