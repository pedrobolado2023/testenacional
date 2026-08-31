FROM nginx:1.27-alpine

# Copiar configuracao do site para conf.d
COPY default.conf /etc/nginx/conf.d/default.conf

# Copiar arquivos do site
COPY . /usr/share/nginx/html/

# Permissoes
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
