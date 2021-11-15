FROM node:lts-alpine3.14

RUN npm install -g depcheck typescript node-sass @vue/compiler-sfc
COPY entrypoint.sh ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
