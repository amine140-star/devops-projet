# Étape 1 : Build Angular
FROM node:18 AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# Étape 2 : Serve via NGINX
FROM nginx:alpine
COPY --from=build /app/dist/twin4-project /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
