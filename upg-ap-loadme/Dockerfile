FROM node:12.18.1
LABEL maintainer="swapnilkhot36@gmail.com"
ENV NODE_ENV=production
WORKDIR /app
COPY ["package.json", "./"]
RUN npm install --production
COPY . .
EXPOSE 8081
CMD [ "node", "server.js" ]
