FROM node:24.16.0-slim

LABEL version=0.2.0

WORKDIR /usr/src/app

COPY runGatlingEcsTask.js ./runGatlingEcsTask.js
COPY awsGatling.js ./awsGatling.js
COPY package.json ./package.json

RUN npm install

ENTRYPOINT [ "node" ]
CMD ["./runGatlingEcsTask.js",  "setting.json" ]
