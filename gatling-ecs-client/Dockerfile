FROM node:6.16.0-slim

LABEL version=0.0.1

WORKDIR /usr/src/app

COPY runGatlingEcsTask.js ./runGatlingEcsTask.js
COPY awsGatling.js ./awsGatling.js
COPY package.json ./package.json

RUN npm install

ENTRYPOINT [ "node" ]
CMD ["./runGatlingEcsTask.js",  "setting.json" ]
