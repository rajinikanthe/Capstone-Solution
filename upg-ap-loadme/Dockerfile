FROM node:12.18.1
LABEL maintainer="rajinikanth.erugu999@gmail.com"
ENV NODE_ENV=production
WORKDIR /app
COPY ["package.json", "./"]
RUN npm install --production
COPY . .
EXPOSE 8081
CMD [ "node", "server.js" ]
