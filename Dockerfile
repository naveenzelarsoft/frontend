FROM      node:8-alpine AS builder
COPY      package.json ./
RUN       npm install && mkdir /frontend && mv ./node_modules ./frontend
WORKDIR   /frontend
COPY       . .
RUN        npm run build




FROM       nginx
COPY       --from=builder /frontend/dist /usr/share/nginx/html
RUN        rm /etc/nginx/conf.d/default.conf
COPY       todo.conf /etc/nginx/conf.d
EXPOSE     80
CMD        /usr/sbin/nginx -g "daemon off;"
