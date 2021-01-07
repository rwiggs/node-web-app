FROM node:15-alpine as build

#create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install --production
RUN npm prune --production
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .


FROM node:15-alpine

COPY --from=build /usr/src/app /
EXPOSE 8080
CMD [ "node", "server.js" ]
