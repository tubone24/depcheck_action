FROM node:lts-alpine3.14

RUN apk --no-cache add curl
RUN npm install -g depcheck typescript node-sass @vue/compiler-sfc
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
