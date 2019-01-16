# Centos based container with Java
FROM centos:centos7

ARG u=elastic
ARG uid=1000
ARG g=elastic
ARG gid=1000
ARG p=elastic

# add USER
RUN groupadd -g ${gid} ${g}
RUN useradd -d /home/${u} -u ${uid} -g ${g} -s /bin/bash ${u} 

# yum settings
RUN yum -y update
RUN yum -y install java-1.8.0-openjdk.x86_64
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64/jre/

# install wget
RUN yum install -y wget

# install net-tools : netstat, ifconfig
RUN yum install -y net-tools


# Binary install
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.tar.gz
RUN tar -xvf elasticsearch-5.4.0.tar.gz
RUN mv elasticsearch-5.4.0 /home/${u}
RUN rm elasticsearch-5.4.0.tar.gz
ENV ELASTIC_HOME=/home/${u}/elasticsearch-5.4.0/

# PATH reset
ENV PATH=${PATH}:${ELASTIC_HOME}/bin

RUN chown -R ${u}:${g} /home/${u}
USER ${u}

EXPOSE 9200 9300

CMD ["elasticsearch"]




