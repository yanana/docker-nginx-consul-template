FROM yanana/phusion-nginx

MAINTAINER Shun Yanaura <metroplexity@gmail.com>

RUN apt-get update && apt-get install -y unzip

ENV DL_URL https://github.com/hashicorp/consul-template/releases/download/v0.11.0/consul_template_0.11.0_linux_amd64.zip
RUN curl -sSL $DL_URL > /consul.zip && unzip /consul.zip -d /usr/bin && rm /consul.zip

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run
RUN find /etc/service -type f -name 'run' -a ! -executable -exec chmod +x {} \;

RUN rm -v /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/nginx.conf

VOLUME /etc/consul-templates

CMD ["my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
