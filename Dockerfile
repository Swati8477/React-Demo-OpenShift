FROM node:current-alpine
WORKDIR /app

COPY package*.json ./app
RUN npm run install

EXPOSE 8080

COPY . .
CMD ["npm","start"]