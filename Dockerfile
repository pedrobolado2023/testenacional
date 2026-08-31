# ============================================================
# Dockerfile — Hotel Nacional Rio de Janeiro (Site Estático)
# Para hospedagem no EasyPanel via Docker
# ============================================================

FROM nginx:1.27-alpine

# Remover config padrão do nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiar configuração customizada do nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copiar todos os arquivos do site estático
COPY . /usr/share/nginx/html/

# Definir permissões corretas
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Expor porta 80
EXPOSE 80

# Healthcheck para EasyPanel
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/robots.txt || exit 1

# Iniciar nginx em foreground
CMD ["nginx", "-g", "daemon off;"]
