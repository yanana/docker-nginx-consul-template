# docker-nginx-consul-template

[Consul Template](https://github.com/hashicorp/consul-template) powered Nginx container.

## Useage

This container is not intended to be used by itself. You have to create a container which inherits this. E.g., with a configuration template app.conf.ctmpl Dockerfile would be:

```
FROM yanana/nginx-consul-template

ADD app.conf.ctmpl /etc/consul-templates/app.conf.ctmpl

CMD ["my_init"]
```

And the template:

```
upstream app {
  least_conn;
  {{range service "some-cool-app"}}server {{.Address}}:{{.Port}} max_fails=3 fail_timeout=60 weight=1;
  {{else}}server 127.0.0.1:65535; # force a 502{{end}}
}
```

And given running [docker-consul](https://github.com/progrium/docker-consul) container named 'consul':

```sh
docker run -d \
  -v /somewhere/to/put/logs:/var/log/nginx:rw \
  --link consul:consul \
  -p port-to-publish-nginx:80 \
  --name container-name \
  -e "SERVICE_NAME=service-name-to-register-to-consul" \
  -e "SERVICE_TAGS=tag1,tag2,tag3" \
  yanana/nginx-consul-template
```

That's all :sushi:
