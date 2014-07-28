# Bento Cluster Docker

A prototype for a Bento cluster (self contained HDFS/YARN/HBase/Cassandra environment). Runs CDH 5 and Cassandra 2 in pseudo-distributed mode.

## Usage

    # build the image
    docker build -t "danburkert/bento" .

    # start the container
    docker run --name bento danburkert/bento

    # Get the Bento address
    BENTO_ADDRESS=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" bento)
    BENTO_HOST=$(docker inspect --format="{{.Config.Hostname}}" bento)

    # Add the Bento hostname to /etc/hosts (required to allow HBase to resolve region servers)
    echo "${BENTO_ADDRESS}	${BENTO_HOST}" | sudo tee -a /etc/hosts

    # Generate client configuration to connect to the Bento
    ./client-conf/generate-client-configs

    # Add client configs to current environment
    source client-conf/client-conf-env

### Web Interfaces

    # HDFS namenode
    open http://$BENTO_HOST:50070

    # YARN resource manager
    open http://$BENTO_HOST:8088

    # HBase master
    open http://$BENTO_HOST:60010

    # Cassandra Opscenter
    open http://$BENTO_HOST:8888

    # supervisord
    open http://$BENTO_HOST:9001

## Installation

#### Linux Host

Requires [Docker](https://docker.com/). Docker [requires](http://docker.readthedocs.org/en/v0.5.3/installation/kernel/) Linux kernel 3.8 or above.

#### OS X Host

1. Requires [boot2docker](https://github.com/boot2docker/boot2docker)
2. Requires a network route to the bento box:
```bash
sudo route add $BENTO_ADDRESS/16 $(boot2docker ip 2> /dev/null)
```
