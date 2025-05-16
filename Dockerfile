FROM s390x/node:20-bullseye

LABEL maintainer="codesenju@gmail.com"

WORKDIR /usr/src/app

COPY package*.json ./

RUN apt-get update && \
    apt-get install -y python3 make g++ gcc curl && \
    npm install && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY libibmc++.so.1 /usr/src/app
ENV LD_LIBRARY_PATH=/usr/src/app:$LD_LIBRARY_PATH

COPY . .

EXPOSE 8081
CMD [ "node", "server.js" ]
