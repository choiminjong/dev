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


# Install prepare infrastructure

RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar
 
RUN yum -y install which
RUN yum -y install net-tools

#환경변수 설정 
RUN yum -y install java-1.8.0-openjdk-devel-1.8.0.191.b12-1.el7_6.x86_64
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-devel-1.8.0.191.b12-1.el7_6.x86_64


# Elasticsearch install
ENV ELASTIC_VERSION=5.4.0

# Binary install
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}.tar.gz
RUN tar -xvf elasticsearch-${ELASTIC_VERSION}.tar.gz
RUN mv elasticsearch-${ELASTIC_VERSION} /home/${u}
RUN rm elasticsearch-${ELASTIC_VERSION}.tar.gz
ENV ELASTIC_HOME=/home/${u}/elasticsearch-${ELASTIC_VERSION}/

# PATH reset
ENV PATH=${PATH}:${ELASTIC_HOME}/bin

RUN chown -R ${u}:${g} /home/${u}
USER ${u}

EXPOSE 9200 9300

CMD ["elasticsearch"]




