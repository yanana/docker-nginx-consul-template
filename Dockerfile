FROM yanana/phusion-nginx

MAINTAINER Shun Yanaura <metroplexity@gmail.com>

ENV DL_URL https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz
RUN curl -sSL $DL_URL | tar -C /usr/local/bin --strip-components 1 -zxf -

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run
RUN find /etc/service -type f -name 'run' -a ! -executable -exec chmod +x {} \;

RUN rm -v /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/nginx.conf

VOLUME /etc/consul-templates

CMD ["my_init"]
