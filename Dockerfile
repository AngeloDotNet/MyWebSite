#FROM node:20.17.0 as builder
FROM node:20.18.1 as builder
WORKDIR /app

COPY package.json package-lock.json ./

#RUN npm install -g npm@10.9.0
RUN npm install -g npm@11.0.0
RUN npm install
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:alpine as runner
COPY --from=builder /app/dist /usr/share/nginx/html