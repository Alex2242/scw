# Docker image for Scaleway CLI

## Usage

A container can be started using:
```sh
docker run -d --name scw_container alex2242/scw:latest
```

The container runs as a daemon and is usable by running commands inside it.
eg `docker exec -it scw_container scw ps`.

The image stores credentials and configuration in a volume so that a container
can be kept over time, although a mounting it on the host filesystem is advised.

Defining an alias make the usage more convienient:
```sh
alias scw="docker exec -it scw_container scw $@"
```
