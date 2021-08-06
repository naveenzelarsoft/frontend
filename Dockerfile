FROM       nginx AS builder
RUN        rm /etc/nginx/conf.d/default.conf
COPY       todo.conf /etc/nginx/conf.d
EXPOSE     80
CMD        /usr/sbin/nginx -g "daemon off;"


FROM      node:8-alpine
COPY      --from=builder package.json package-lock.json /usr/share/nginx/html
WORKDIR   /usr/share/nginx/html
RUN       npm install
RUN       npm run build
CMD       /usr/sbin/nginx -g "daemon off;"
