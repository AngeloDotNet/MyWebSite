#FROM node:20.18.3 as builder
#FROM node:22.16.0 as builder
FROM node:22.17.0 as builder
WORKDIR /app

COPY package.json package-lock.json ./

#RUN npm install -g npm@11.3.0
#RUN npm install -g npm@11.4.1
RUN npm install -g npm@11.4.2
RUN npm install
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:alpine as runner
COPY --from=builder /app/dist /usr/share/nginx/html
