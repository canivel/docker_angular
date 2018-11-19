#Stage 1: Build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
RUN npm install -g @angular/cli
COPY . .
RUN ng build

#Stage 2: nginx phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/dist/* /usr/share/nginx/html