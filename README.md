## Docker image to experiment with HTTP2 protocol using h2o web server

    docker run -P -d --name h2o revollat/h2o

This will publish to http and https port to the docker host

then access with a recent version of your browser to 

    https://127.0.0.1.xip.io:32768/

Replace 32768 with the port given by the `docker ps` command (the forwarded port to 443 in the container)  

### Use your own config

```bash
mkdir test && cd test
wget https://raw.githubusercontent.com/revollat/docker-h2o-http2-server/master/conf/h2o.conf
mkdir docroot && echo "test" > docroot/index.htm
```

Edit `h2o.conf` if necessary, and run the container :

```bash
docker run -P -d -v $(pwd)/h2o.conf:/etc/h2o/h2o.conf -v $(pwd)/docroot:/var/www revollat/h2o
```

Get some help :

    docker run revollat/h2o h2o -h

Visit h2o website : http://h2o.github.io/

