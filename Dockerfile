FROM s390x/node:12-buster

LABEL maintainer="codesenju@gmail.com"

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install build tools and dependencies
COPY package*.json ./

RUN apt-get update && \
    apt-get install -y python3 make g++ gcc curl && \
    npm install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy required library
COPY libibmc++.so.1 /usr/src/app

# Set library path
ENV LD_LIBRARY_PATH=/usr/src/app:$LD_LIBRARY_PATH

# Copy remaining app source
COPY . .

EXPOSE 8081

CMD [ "node", "server.js" ]
