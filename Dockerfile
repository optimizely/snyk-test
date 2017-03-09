FROM mhart/alpine-node:7

# package.json has git deps
RUN apk update && apk add git

WORKDIR /app

COPY package.json /app
RUN npm install
RUN npm prune --production

CMD ls node_modules
