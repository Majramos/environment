# Containers used in selfhost

## Services
### network
create a network to connect all containers and use a reverse proxy

```bash
$ docker network create reverse_proxy
```

add `127.0.0.1 local.lab` to hosts file

- Linux `/etc/hosts`
- Windows `C:\Windows\System32\drivers\etc\hosts`
- Mac `/private/etc/hosts`

### Caddy
reverse proxy

Site:
- https://caddyserver.com/


Documentation on docker instalation:
- https://linuxiac.com/how-to-set-up-caddy-as-reverse-proxy/#h-set-up-caddy-as-a-reverse-proxy-in-a-docker-container

```bash
$ docker compose -f .\caddy\compose.yaml up -d
```

reload caddy config
```bash
$ caddy reload --config /etc/caddy/Caddyfile
```

### Portainer
container management

Site:
- https://www.portainer.io/

Documentation on docker instalation:
- https://docs.portainer.io/start/install-ce/server/docker/linux

```bash
$ docker compose -f .\portainer\compose.yaml up -d
```

### SearXNG
meta-search engine

Site:
- https://github.com/searxng/searxng
- https://github.com/searxng/searxng-docker

Documentation on docker instalation:
- https://docs.searxng.org/admin/installation-docker.html

Setup browser search
- https://<host ip>/?q=%s

```bash
$ docker compose -f .\searxng\compose.yaml up -d
```

### IT-Tools
general tools

Site:
- https://github.com/CorentinTh/it-tools

Documentation on docker instalation:
- https://github.com/CorentinTh/it-tools/pull/461

```bash
$ docker compose -f .\it-tools\compose.yaml up -d
```

### Stirling-Tools
general tools

Site:
- https://www.stirlingpdf.com/

Documentation on docker instalation:
- https://github.com/Stirling-Tools/Stirling-PDF

```bash
$ docker compose -f .\stirling-pdf\compose.yaml up -d
```

### Tasks.md
A self-hosted, Markdown file based task management board.

Site:
- https://github.com/BaldissaraMatheus/Tasks.md

Documentation on docker instalation:
- https://github.com/BaldissaraMatheus/Tasks.md?tab=readme-ov-file#-installation

```bash
$ docker compose -f .\tasks.md\compose.yaml up -d
```

### Homepage
application dashboard

Site:
- https://gethomepage.dev/

Documentation on docker instalation:
- https://gethomepage.dev/installation/docker/

```bash
$ docker compose -f .\homepage\compose.yaml up -d
```

### uptime-kuma

Site:
- https://uptimekuma.org/

```bash
$ docker compose -f .\uptime\compose.yaml up -d
```

### Actual Budget

Site:
- https://actualbudget.org/

```bash
$ docker compose -f .\actualbudget\compose.yaml up -d
```
