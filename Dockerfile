FROM node:16-alpine3.14
WORKDIR '/app'

# ENV PATH /app/node_modules/.bin:$PATH

COPY package.json .
RUN npm install

# EXPOSE 8080

COPY . .
CMD ["npm","start"]




