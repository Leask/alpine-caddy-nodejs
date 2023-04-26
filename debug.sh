docker build . --no-cache --file Dockerfile --tag leask/alpine-caddy-nodejs
docker run -i --rm --name caddy-nodejs -p 80:80 -p 443:443 -p 2019:2019 leask/alpine-caddy-nodejs
