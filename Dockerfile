ARG GRAFANA_VERSION="latest"

FROM grafana/grafana:${GRAFANA_VERSION}

EXPOSE 8080 8080

COPY health-check /health-check
COPY entrypoint.sh /start-nginx-grafana.sh

USER root

RUN apt-get update && apt-get install -y nginx
RUN chown -R grafana:grafana /etc/nginx/nginx.conf /var/log/nginx /var/lib/nginx /start-nginx-grafana.sh
RUN chmod +x /start-nginx-grafana.sh

USER grafana

RUN cp /health-check/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT [ "/entrypoint.sh" ]
