FROM ubuntu:14.04                                                                                                       

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y libtool automake libyaml-dev libssl-dev cmake git build-essential

WORKDIR /tmp
RUN git clone https://github.com/h2o/h2o.git
RUN git clone https://github.com/libuv/libuv.git

# Build last version of libuv
WORKDIR /tmp/libuv
RUN sh autogen.sh && ./configure && make && make install

# Build h2o HTTP server
WORKDIR /tmp/h2o
RUN cmake -DWITH_BUNDLED_SSL=on .
RUN make && make install

RUN mv /tmp/h2o/examples/h2o /etc/h2o
RUN mkdir /var/www

# Clean source
RUN rm -rf /tmp/h2o
RUN rm -rf /tmp/libuv

VOLUME ["/etc/h2o", "/var/www"]

WORKDIR /var/www

EXPOSE 80
EXPOSE 443

COPY conf/h2o.conf /etc/h2o/h2o.conf
COPY docroot /var/www

CMD ["h2o","-c","/etc/h2o/h2o.conf"]