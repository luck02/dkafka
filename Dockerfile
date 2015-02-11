FROM ubuntu:14.04
MAINTAINER Gary Lucas

ENV DEBIAN_FRONTEND noninteractive

# accept-java-license
RUN echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install software-properties-common -yq

RUN apt-get update && \
  apt-get install -yq python-software-properties && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get remove -yq python-software-properties && \
    apt-get autoremove -yq && \
    apt-get clean -yq && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -yq oracle-java8-installer oracle-java8-set-default && \
    apt-get autoremove -yq && \
    apt-get clean -yq && \
    rm -rf /var/lib/apt/lists/*

ADD install_kafka.sh /usr/local/kafka/install_kafka.sh 
RUN /usr/local/kafka/install_kafka.sh
WORKDIR /usr/local/kafka/kafka_2.9.2-0.8.2.0

ADD run_kafka.sh   /usr/local/kafka/kafka_2.9.2-0.8.2.0/run_kafka.sh
CMD ["/bin/bash", "/usr/local/kafka/kafka_2.9.2-0.8.2.0/run_kafka.sh"]


