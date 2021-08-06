FROM       nginx AS builder
CMD        mkdir /frontend
COPY       . ./frontend
RUN        rm /etc/nginx/conf.d/default.conf
COPY       todo.conf /etc/nginx/conf.d
EXPOSE     80
CMD        /usr/sbin/nginx -g "daemon off;"


FROM      node:8-alpine
COPY      --from=builder ./frontend /usr/share/nginx/html/frontend
WORKDIR   /usr/share/nginx/html/frontend
RUN       npm install
RUN       npm run build
CMD       /usr/sbin/nginx -g "daemon off;"
