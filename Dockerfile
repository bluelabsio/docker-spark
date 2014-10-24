FROM ubuntu:14.04
MAINTAINER Chelsea Zhang <chelsea@bluelabs.com>

# Based on https://github.com/amplab/docker-scripts/blob/master/spark-1.0.0/spark-base/Dockerfile

RUN apt-get update && \
    apt-get install -q -y wget openjdk-7-jre-headless python && \
    apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV SCALA_VERSION 2.10.4
ENV SPARK_VERSION 1.1.0
ENV SCALA_HOME /opt/scala-$SCALA_VERSION
ENV SPARK_HOME /opt/spark-$SPARK_VERSION
ENV PATH $SPARK_HOME:$SCALA_HOME/bin:$PATH

# Install Scala
ADD http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz /
RUN (cd / && gunzip < scala-$SCALA_VERSION.tgz)|(cd /opt && tar -xvf -)
RUN rm /scala-$SCALA_VERSION.tgz

# Install Spark 
ADD http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_VERSION-bin-hadoop2.4.tgz /
RUN (cd / && gunzip < spark-$SPARK_VERSION-bin-hadoop2.4.tgz)|(cd /opt && tar -xvf -)
RUN (ln -s /opt/spark-$SPARK_VERSION-bin-hadoop2.4 /opt/spark-$SPARK_VERSION && rm /spark-$SPARK_VERSION-bin-hadoop2.4.tgz)

CMD $SPARK_HOME/bin/spark-shell