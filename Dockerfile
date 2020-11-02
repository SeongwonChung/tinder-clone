#from base image node
FROM node:lts-alpine3.12

WORKDIR /usr/app

ENV PATH /usr/app/node_modules/.bin:$PATH

#copy package.json
COPY ./package.json ./

#install packages
RUN npm install 

COPY ./ ./

RUN npm run build
# /usr/app/build 에 소스코드 담긴다.

#second block - nginx
FROM nginx
EXPOSE 80

COPY --from=0 /usr/app/build /usr/share/nginx/html