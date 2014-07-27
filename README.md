# Bento Cluster Docker

A prototype for a Bento cluster (self contained HDFS/YARN/HBase/Cassandra environment). Runs CDH 5.1 in pseudo-distributed mode.

## Usage

	# build the image
	docker build -t "danburkert/bento" .
	
	



## Installation

#### Linux Host

Requires [Docker](https://docker.com/). Docker [requires](http://docker.readthedocs.org/en/v0.5.3/installation/kernel/) Linux kernel 3.8 or above.

#### OS X Host

1. Requires [boot2docker](https://github.com/boot2docker/boot2docker)
2. Requires a network route to the bento box: `sudo route add 172.17.0.0/16 $(boot2docker ip 2> /dev/null)`
   Where 172.17.0.0 is the output of `docker inspect --format="{{.NetworkSettings.IPAddress}}" bento`