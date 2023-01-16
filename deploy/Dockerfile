FROM node:18.13.0-alpine3.17 AS node
RUN mkdir /app && chown -R node:node /app

FROM node AS deps
USER node
WORKDIR /app
COPY --chown=node package.json yarn.lock ./
RUN yarn install

FROM node AS builder
USER node
WORKDIR /app
ENV NODE_ENV=production
ENV MEDUSA_BACKEND_URL=https://backend.stenar.si
ENV MEDUSA_FF_ANALYTICS=false
COPY --chown=node . .
COPY --chown=node --from=deps /app/node_modules ./node_modules
RUN yarn build

FROM nginx:1.23.3-alpine as release
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --chown=nginx --from=builder /app/public /usr/share/nginx/html

EXPOSE 8080
ENTRYPOINT ["nginx", "-g", "daemon off;"]
