FROM ubuntu:latest
MAINTAINER Silva Song "silva.song@aliyun.com"

#安装JDK  this block is replaced!
#RUN apt-get update
#RUN apt-get install -y openjdk-7-jdk && apt-get install -y wget

#安装JDK8
#添加ppa
RUN apt-get update -y                             && \
    apt-get install software-properties-common python-software-properties -y && \
    add-apt-repository ppa:webupd8team/java -y    && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get update -y                             && \
    apt-get install oracle-java8-installer -y
RUN java -version


#RUN add-apt-repository ppa:webupd8team/java
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
#RUN apt-get update && apt-get clean
#RUN apt-get install -y oracle-java8-installer

#安装tomcat
RUN mkdir /var/tmp/tomcat
RUN wget -P /var/tmp/tomcat http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-8.0.33.tar.gz -C /var/tmp/tomcat
RUN rm -rf /var/tmp/tomcat/apache-tomcat-8.0.33.tar.gz 

#安装maven
RUN mkdir /var/tmp/maven
RUN wget -P /var/tmp/maven http://mirrors.cnnic.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xzf /var/tmp/maven/apache-maven-3.3.9-bin.tar.gz -C /var/tmp/maven
RUN rm -rf /var/tmp/maven/apache-maven-3.3.9-bin.tar.gz
#设置maven环境变量
ENV MAVEN_HOME=/var/tmp/maven/apache-maven-3.3.9
ENV PATH=$MAVEN_HOME/bin:$PATH



RUN mkdir /var/tmp/webapp
ADD ./ /var/tmp/webapp
RUN cd /var/tmp/webapp && mvn package && cp /var/tmp/webapp/target/CIJD.war /var/tmp/tomcat/apache-tomcat-8.0.33/webapps

EXPOSE 8080

CMD ["./var/tmp/tomcat/apache-tomcat-8.0.33/bin/catalina.sh","run"]

