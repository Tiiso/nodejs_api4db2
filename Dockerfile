FROM s390x/node:12

LABEL maintainer="codesenju@gmail.com"

# Create app directory
WORKDIR /usr/src/app

# Install dependencies first
COPY package*.json ./
RUN apt-get update && apt-get install -y python3 make g++ gcc \
    && npm install

# Copy required library
COPY libibmc++.so.1 /usr/src/app

# Set library path for ibm_db
ENV LD_LIBRARY_PATH=/usr/src/app:$LD_LIBRARY_PATH

# Copy application source
COPY . .

# App listens on port 8081
EXPOSE 8081

# Start the server
CMD [ "node", "server.js" ]
