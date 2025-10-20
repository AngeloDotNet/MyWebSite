#FROM node:24.4.1 as builder
FROM node:24.8.0 as builder
WORKDIR /app

COPY package.json package-lock.json ./

#RUN npm install -g npm@11.5.2
#RUN npm install -g npm@11.6.1
RUN npm install -g npm@11.6.2

RUN npm install
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:alpine as runner
COPY --from=builder /app/dist /usr/share/nginx/html
