FROM s390x/node
MAINTAINER codesenju "codesenju@gmail.com"

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY libibmc++.so.1 /usr/src/app
RUN cd /usr/src/app
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/src/app
COPY . .

EXPOSE 8081
CMD [ "node", "server.js" ]
