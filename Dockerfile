FROM s390x/node
MAINTAINER codesenju "codesenju@gmail.com"

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

#COPY IBM_XL_C_CPP_V1.2.0.0_LINUX_390_RUNTIME.tar.gz /usr/src/app
COPY libibmc++.so.1 /usr/src/app
RUN cd /usr/src/app
#RUN tar -zxvf IBM_XL_C_CPP_V1.2.0.0_LINUX_390_RUNTIME.tar.gz
#RUN ./install
#RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ibm/lib64/
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/src/app
#RUN export FLASK_APP=app.py

COPY . .

EXPOSE 8081
CMD [ "node", "server.js" ]
