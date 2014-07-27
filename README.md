# Bento Cluster Docker

A prototype for a Bento cluster (self contained HDFS/YARN/HBase/Cassandra environment). Runs CDH 5 and Cassandra 2 in pseudo-distributed mode.

## Usage

	# build the image
	docker build -t "danburkert/bento" .
	
	# start the container
	docker run --name bento danburkert/bento
	
	# Get the Bento address
	BENTO_ADDRESS=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" bento)
	
	# Open the web interfaces
	open $BENTO_ADDRESS:50010 # HDFS namenode
	open $BENTO_ADDRESS:8088  # YARN resource manager
	open $BENTO_ADDRESS:60010 # HBase master
	open $BENTO_ADDRESS:9001  # supervisord
	open $BENTO_ADDRESS:8888  # Cassandra Opscenter
	
## Installation

#### Linux Host

Requires [Docker](https://docker.com/). Docker [requires](http://docker.readthedocs.org/en/v0.5.3/installation/kernel/) Linux kernel 3.8 or above.

#### OS X Host

1. Requires [boot2docker](https://github.com/boot2docker/boot2docker)
2. Requires a network route to the bento box: `sudo route add $BENTO_ADDRESS/16 $(boot2docker ip 2> /dev/null)`