FROM centos:centos6
MAINTAINER Dan Burkert <dan@danburkert.com>

RUN yum clean all

# Install Java 7 and Yum utils (needed for the `yum-config-manager` tool)
RUN yum install -y java-1.7.0-openjdk.x86_64 yum-utils

# Add the Cloudera CDH5 Yum repository
RUN yum-config-manager --add-repo http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo

RUN yum install -y \
  zookeeper-server \
  hadoop-hdfs-namenode \
  hadoop-hdfs-datanode \
  hadoop-yarn-resourcemanager \
  hadoop-yarn-nodemanager \
  hadoop-yarn-proxyserver \
  hadoop-mapreduce \
  hadoop-mapreduce-historyserver \
  hbase-master \
  hbase-regionserver

ADD hadoop-conf /etc/hadoop/conf.bento
RUN alternatives --verbose --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bento 50
RUN alternatives --set hadoop-conf /etc/hadoop/conf.bento

ADD zookeeper-conf /etc/zookeeper/conf.bento
RUN alternatives --verbose --install /etc/zookeeper/conf zookeeper-conf /etc/zookeeper/conf.bento 50
RUN alternatives --set zookeeper-conf /etc/zookeeper/conf.bento

ADD hbase-conf /etc/hbase/conf.bento
RUN alternatives --verbose --install /etc/hbase/conf hbase-conf /etc/hbase/conf.bento 50
RUN alternatives --set hbase-conf /etc/hbase/conf.bento

# Format namenode
USER hdfs
RUN hdfs namenode -format

USER root
