FROM node:14-alpine

WORKDIR /usr/src/app
COPY . /usr/src/app
EXPOSE 2023
RUN npm install
RUN npm install -g nodemon

ENTRYPOINT ["node", "/usr/src/app/index.js"]