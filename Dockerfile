FROM alpine:3.8
LABEL maintainer="alexandre.degurse@gmail.com"
ARG SCW_VERSION=v1.17
ARG SCW_UID=1337

# get scw bin
RUN apk add --update --no-cache curl &&\
    curl -sSL -o /usr/bin/scw https://github.com/scaleway/scaleway-cli/releases/download/${SCW_VERSION}/scw-linux-amd64 &&\
    apk del --purge curl && rm -Rf /var/cache/apk &&\
    chmod 755 /usr/bin/scw

# config container
# see stackoverflow.com/a/35613430 to understand the next line
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 &&\
    apk add --no-cache ca-certificates &&\
    adduser -Dh /home/scw -u${SCW_UID} scw &&\
    chmod 755 /usr/bin/scw &&\
    mkdir /scw && chown scw:scw /scw

USER scw
WORKDIR /home/scw

# create empty scwrc, for usage without mount
RUN echo "{}" > /scw/scwrc.json &&\
    chmod 700 /scw/scwrc.json &&\
    ln -s /scw/scwrc.json /home/scw/.scwrc

VOLUME ["/scw"]

# container is a deamon waiting for commands to be executed
# with docker exec
CMD ["/bin/sleep", "24h"]
