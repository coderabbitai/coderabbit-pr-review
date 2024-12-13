# Dockerfile for auth-service
FROM node:14

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install

COPY . .
CMD ["node", "server.js"]
