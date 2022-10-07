FROM node:14.18.0-alpine3.12 as common-build-stage

WORKDIR /app

COPY . ./

# Create log files
RUN mkdir -p src/Main/tmp/logs
WORKDIR /app/src/Main/tmp/logs/
RUN touch error.log fatal.log info.log warn.log trace.log

RUN yarn install

EXPOSE 3002

FROM common-build-stage as development-build-stage

ENV NODE_ENV dev

CMD ["yarn", "dev"]

FROM common-build-stage as production-build-stage

ENV NODE_ENV production

RUN yarn build
ENTRYPOINT ["yarn", "start"]