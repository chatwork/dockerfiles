FROM node:16.3.0-slim

LABEL version=0.1.2

WORKDIR /usr/src/app

COPY runGatlingEcsTask.js ./runGatlingEcsTask.js
COPY awsGatling.js ./awsGatling.js
COPY package.json ./package.json

RUN npm install

ENTRYPOINT [ "node" ]
CMD ["./runGatlingEcsTask.js",  "setting.json" ]
