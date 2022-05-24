# FROM node:current-alpine
# WORKDIR /app

# ENV PATH /app/node_modules/.bin:$PATH

# COPY package*.json ./app
# RUN npm install

# EXPOSE 8080

# COPY . .
# CMD ["npm","start"]

# Step 1

FROM node:10-alpine as build-step

RUN mkdir /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build

# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/build /usr/share/nginx/html